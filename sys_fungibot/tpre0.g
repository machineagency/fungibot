; Runs after freeing the previous tool if the next tool is tool-1.
; Note: tool offsets are not applied at this point!

; tpre1.g

G0 X148.8 Y225 F17000  ; Rapid to the approach position without any current tool.

G60 S2               ; Save this position as the reference point from which to later apply new tool offsets.


