﻿; --------------------------------------------------------------------
; 光碟控制
;
; Win + NumpadDot         預設光碟機 [退片／進片]
; --------------------------------------------------------------------
#NumpadDot::DriveEject()

; --------------------------------------------------------------------
; 預設光碟機 [進片／退片]
; --------------------------------------------------------------------
DriveEject()
{
    global DefaultDrive
    Drive, Eject
    If (A_TimeSinceThisHotkey < 1000)
    {
        Drive, Eject, %DefaultDrive%, 1
    }
}
