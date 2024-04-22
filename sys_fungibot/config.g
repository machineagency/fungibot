; Jubilee CoreXY ToolChanging Printer - Config File
; This file intended for Duet 3 hardware, main board plus one expansion boards

; Name and network
; This is configured from the connected Raspberry Pi or here if in stand alone
; mode
;-------------------------------------------------------------------------------
; Networking
; Networking handled by Duet. Comment out if running the Duet in SBC Mode with Pi.
M550 P"Dubilee"           ; Name used in ui and for mDNS  http://Jubilee.local
M552 P192.168.1.2 S1      ; Use Ethernet with a static IP, 0.0.0.0 for dhcp
M554 192.168.1.3          ; Gateway
M553 P255.255.255.0       ; Netmask


; General setup
;-------------------------------------------------------------------------------
M111 S0                    ; Debug off 
M929 P"eventlog.txt" S1    ; Start logging to file eventlog.txt

; General Preferences
M555 P2                    ; Set Marlin-style output
G21                        ; Set dimensions to millimetres
G90                        ; Send absolute coordinates...
M83                        ; ...but relative extruder moves


; Stepper mapping
;-------------------------------------------------------------------------------
M584 X1.0 Y1.1            ; X and Y for CoreXY
M584 U1                   ; U for toolchanger lock
M584 Z2:3:4               ; Z has three drivers for kinematic bed suspension. 
M584 E0.0:1.2             ; Two extruders

M569 P1.0 S0              ; 3HC Drive 0 | X stepper | Port 0
M569 P1.1 S0              ; 3HC Drive 1 | Y Stepper | Port 1
;M906 X{0.85*sqrt(2)*2000} ; LDO XY 2000mA RMS the TMC5160 driver on duet3
;M906 Y{0.85*sqrt(2)*2000} ; generates a sinusoidal coil current so we can
M906 X{0.85*sqrt(2)*2500} ; LDO XY 2000mA RMS the TMC5160 driver on duet3
M906 Y{0.85*sqrt(2)*2500} ; generates a sinusoidal coil current so we can 
                          ; multply by sqrt(2) to get peak used for M906
                          ; Do not exceed 90% without heatsinking the XY 
                          ; steppers.
                                            
M569 P0.1 S0                ; Drive 1 | U Tool Changer Lock  670mA
M906 U670 I60             ; 100% of 670mA RMS. idle 60%
                          ; Note that the idle will be shared for all drivers

M569 P0.2 S0                ; Drive 2 | Front Left Z
M569 P0.3 S0                ; Drive 3 | Front Right Z
M569 P0.4 S0                ; Drive 4 | Back Z
M906 Z{0.7*sqrt(2)*1680}  ; 70% of 1680mA RMS

M906 E{0.8*2800}:450 									          ; 80% of 2800mA Peak current rating for tool 0; 450mA for tool 1

; Kinematics
;-------------------------------------------------------------------------------
M669 K1                   ; CoreXY mode

; Kinematic bed ball locations.
; Locations are extracted from CAD model assuming lower left build plate corner
; is (0, 0) on a 305x305mm plate.
M671 X297.5:2.5:150 Y313.5:313.5:-16.5 S10 ; Front Left: (297.5, 313.5)
                                           ; Front Right: (2.5, 313.5)
                                           ; Back: (150, -16.5)
                                           ; Up to 10mm correction


; Axis and motor configuration 
;-------------------------------------------------------------------------------

M350 X1 Y1 Z1 U1       ; Disable microstepping to simplify calculations
M92 X{1/(0.9*16/180)}  ; step angle * tooth count / 180
M92 Y{1/(0.9*16/180)}  ; The 2mm tooth spacing cancel out with diam to radius
;M92 X{1/(1.8*16/180)}  ; step angle * tooth count / 180
;M92 Y{1/(1.8*16/180)}  ; The 2mm tooth spacing cancel out with diam to radius
M92 Z{360/0.9/2}       ; 0.9 deg stepper / lead (2mm) of screw for Dubilee 
M92 U{13.76/1.8}       ; gear ratio / step angle for tool lock geared motor.
;M92 E51.875            ; Extruder - BMG 0.9 deg/step

; Enable microstepping all step per unit will be multiplied by the new step def
M350 X16 Y16 I1        ; 16x microstepping for CoreXY axes. Use interpolation.
M350 U4 I1             ; 4x for toolchanger lock. Use interpolation.
M350 Z16 I1            ; 16x microstepping for Z axes. Use interpolation.
;M350 E16:16 I1         ; 16x microstepping for Extruder axes. Use interpolation.

; Speed and acceleration
;-------------------------------------------------------------------------------
M201 X2000 Y2000                        ; Accelerations (mm/s^2)
M201 Z100                               ; LDO ZZZ Acceleration
M201 U800                               ; LDO U Accelerations (mm/s^2)
;M201 E1300                              ; Extruder

M203 X18000 Y18000 Z800 U9000           ; Maximum axis speeds (mm/min)
M566 X500 Y500 Z500 E3000 U50           ; Maximum jerk speeds (mm/min)



; Endstops and probes 
;-------------------------------------------------------------------------------
M574 X1 S1 P"^1.io0.in"  ; 3HC homing position X1 = axis min, type S1 = switch
M574 Y1 S1 P"^1.io1.in"  ; 3HC homing position Y1 = axis min, type S1 = switch
M574 U1 S1 P"^io1.in"  ; homing position U1 = axis min, type S1 = switch

M574 Z0                ; we will use the switch as a Z probe not endstop 
M558 P8 C"io0.in" H3 F360 T6000 ; H = dive height F probe speed T travel speed
G31 K0 X0 Y0 Z-2        ; Set the limit switch as the "Control Point"
                        ; Offset it downwards slightly so we don't smear it 
                        ; along the bed while traveling when z=0

; Set axis software limits and min/max switch-triggering positions.
; Adjusted such that (0,0) lies at the lower left corner of a 300x300mm square 
; in the 305mmx305mm build plate.
M208 X-13.75:313.75 Y-44:341 Z0:295
M208 U0:200            ; Set Elastic Lock (U axis) max rotation angle

; Call out to the tool-specific file 
;M98 P"/sys/tool_0.g"
;M98 P"/sys/tool_1.g"

; Heaters and temperature sensors
;-------------------------------------------------------------------------------

; Bed
M308 S0 P"0.temp0" Y"thermistor" T100000 B3950 A"Bed" ; Keenovo thermistor
M950 H0 C"0.out0" T0                  ; H = Heater 0
                                    ; C is output for heater itself
                                    ; T = Temperature sensor
M143 H0 S100                        ; Set maximum temperature for bed to 100C    
;M307 H0 B0 S1.00 ; Keenovo 750w 230v built in thermistor
                                    ; mandala rose bed
M140 H0                             ; Assign H0 to the bed


; Tool definitions
;-------------------------------------------------------------------------------
M569 P0.0 S0				; 0.0 goes backward
M569 P1.2 S1				; 1.2 goes forward
M563 P0 S"Shroom extruder" D0:1; Px = Tool number
                            ; Dx = Drive Number - not the address
                            ; H1 = Heater Number
M568 P0 S1 					; Enable mixing for tool 0
M567 P0 E1.00:470			; define mixing ratio

                            ; Fx = Fan number print cooling fan
M350 E16:16 I1                  ; Microstep Factor with interpolation
M92 E24480:200					; steps per mm - 1.8 deg stepper / lead (2mm) of screw gear ratio 15.3
M201 E1000:1000					; Extruder Acceleration
M203 E500:500
;G10 P0 X0 Y44.8679 Z0
G10 P0 X0 Y44.8679 Z-23.72
;G10  P0 S0 R0               ; Set tool 0 operating and standby temperatures
                            ; (-273 = "off")
;M572 D0 S0.085              ; Set pressure advance


;M98  P"/sys/Toffsets.g"     ; Set tool offsets from the bed


M501                        ; Load saved parameters from non-volatile memory
