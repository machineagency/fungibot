; Orbiter extruder definition
M308 S1 P"1.temp0" Y"thermistor" T100000 B4725 C7.060000e-8 R2200 A"Baby"		; Thermistor for T1 extruder heater
M950 H1 C"0.out1" T1								; Heater for extruder out toolboad tool 0
M143 H1 S300									; Set maximum temperature for hotend to 300C


M307 H1 A417.0 C97.8 D0.9 V23.9 B0 						;Auto tune results

M950 F1 C"1.out6"								; Define Hotend Fan on out1
M106 P1 S255 T45 H1								; Setup Hotend Fan for thermal control, full on when H1 reaches 45C

M950 F0 C"1.out7"								; Define Part Cooling fan on out2
M106 P0 C"Baby Bullet - Part Fan"							; Setup Part Cooling Fan as Part Cooling T0

M563 P1 S"Baby Bullet" D1 H1 F0							
; Px = Tool number, Dx = Drive Number (start at 0, after movement drives), Hx = Heater Number, Fx = Fan number print cooling fan
M569 P1.2 S1 D2; Orbiter 0 Reverse Direction and Spreadcycle Mode
;M92 E681					; steps per mm
;M906 E450 									;motor current mA

G10 P1 S0 R0									; Set tool 1 operating and standby temperatures(-273 = "off")
G10 P1 Y32.75 Z-1.78
M572 D1 S0.03									; Set Pressure Advance On

 
;Heater 1 model: gain 417.0, time constant 97.8, dead time 0.9, max PWM 1.00, calibration voltage 23.9, mode PID
;Computed PID parameters for setpoint change: P46.7, I4.982, D29.3
;Computed PID parameters for load change: P46.7, I14.120, D29.3
