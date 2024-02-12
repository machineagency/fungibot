; Runs after freeing the previous tool if the next tool is tool-0.
; Note: tool offsets are not applied at this point!

; tpre0.g

G0 X45 Y225 F17000  ; Rapid to the approach position without any current tool.

G60 S2               ; Save this position as the reference point from which to later apply new tool offsets.
