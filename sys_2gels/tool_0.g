M308 S2 P"0.temp1" Y"thermistor" T100000 B3950 A"Syringe jacket"		; Thermistor for T0 extruder heater

M950 H2 C"0.out5" T2								; Heater for extruder out toolboad tool 0
M143 H2 S100									; Set maximum temperature for hotend to 100C

;M584 E0.0 R0 S0             ; Gel Extruder with linear plunger
;M906 E{0.8*1300}             ; 80% of 1300mA Peak current rating
M563 P0 S"GelExtruder #1" D0.0 H2; Px = Tool number
                            ; Dx = Drive Number
                            ; H1 = Heater Number
M569 P0.0 S0				; Invert drive 0.0 (Gel Extruder)
                            ; Fx = Fan number print cooling fan
;M350 E16 I1                  ; Microstep Factor with interpolation
;M92 E3200					; steps per mm
;M201 E1000					; Extruder Acceleration
;M203 E500

G10 P0 X0 Y44.8679 Z-28
G10  P0 S0 R0               ; Set tool 0 operating and standby temperatures
                            ; (-273 = "off")
M302 P1      ; disable cold extrusion checking
;M302 S0      ; always allow extrusion (disable checking)
;M572 D0 S0.085              ; Set pressure advance


;M98  P"/sys/Toffsets.g"     ; Set tool offsets from the bed


M501                        ; Load saved parameters from non-volatile memory