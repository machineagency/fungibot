; File "0:/gcodes/honeycomb_no_wall.gcode" resume print after print paused at 2024-04-05 12:18
G21
M140 P0 S20.0
G29 S1
T-1 P0
G92 X149.266 Y193.042 Z-22.610 U0.000
G60 S1
G10 P0 S90 R20
T0 P0
M98 P"resurrect-prologue.g"
M116
M290 X0.000 Y0.000 Z-1.100 U0.000 R0
T-1 P0
T0 P6
; Workplace coordinates
G10 L2 P1 X0.00 Y0.00 Z0.00 U0.00
G10 L2 P2 X0.00 Y0.00 Z0.00 U0.00
G10 L2 P3 X0.00 Y0.00 Z0.00 U0.00
G10 L2 P4 X0.00 Y0.00 Z0.00 U0.00
G10 L2 P5 X0.00 Y0.00 Z0.00 U0.00
G10 L2 P6 X0.00 Y0.00 Z0.00 U0.00
G10 L2 P7 X0.00 Y0.00 Z0.00 U0.00
G10 L2 P8 X0.00 Y0.00 Z0.00 U0.00
G10 L2 P9 X0.00 Y0.00 Z0.00 U0.00
G54
M106 S0.00
M116
G92 E0.00000
M83
M486 S-1G17
M23 "0:/gcodes/honeycomb_no_wall.gcode"
M26 S1325203
G0 F6000 Z8.800
G0 F6000 X149.266 Y148.174 U0.000
G0 F6000 Z6.800
G1 F1800.0 P0
G21
M24
