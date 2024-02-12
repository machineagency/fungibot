;M584 E0.0 R0 S0             ; Gel Extruder with linear plunger
;M906 E{0.8*1300}             ; 80% of 1300mA Peak current rating
M563 P0 S"GelExtruder" D0.0; Px = Tool number
                            ; Dx = Drive Number
                            ; H1 = Heater Number
M569 P0.0 S0				; Invert drive 0.0 (Gel Extruder)
                            ; Fx = Fan number print cooling fan
M350 E16 I1                  ; Microstep Factor with interpolation
M92 E3200					; steps per mm
M201 E1000					; Extruder Acceleration
M203 E500

G10 P0 X0 Y44.8679 Z-27.51
;G10  P0 S0 R0               ; Set tool 0 operating and standby temperatures
                            ; (-273 = "off")
;M572 D0 S0.085              ; Set pressure advance


;M98  P"/sys/Toffsets.g"     ; Set tool offsets from the bed


M501                        ; Load saved parameters from non-volatile memory
