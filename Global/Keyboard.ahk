; --------------------------------------------------------------------
; 鍵盤設定
;
; Win + \                 鍵盤游標加速
; --------------------------------------------------------------------
#\::SetKeyboard(0, 31, 200)

; --------------------------------------------------------------------
; 鍵盤游標加速
; --------------------------------------------------------------------
SetKeyboard(Delay, Speed, Blink)
{
    ; 設定重複輸入的延遲時間
    ; SPI_SETKEYBOARDDELAY = 0x17
    ; HKCU\Control Panel\Keyboard, KeyboardDelay = 0～3
    DllCall("SystemParametersInfo", UInt, 0x17, UInt, Delay, UInt, 0, UInt, 1)

    ; 設定重複速度
    ; SPI_SETKEYBOARDSPEED = 0xB
    ; HKCU\Control Panel\Keyboard, KeyboardSpeed = 0～31
    DllCall("SystemParametersInfo", UInt, 0xB, UInt, Speed, UInt, 0, UInt, 1)

    ; 設定游標閃爍頻率
    ; HKCU\Control Panel\Desktop, CursorBlinkRate = 200～1200 (ms) (No Blink = -1)
    DllCall("SetCaretBlinkTime", UInt, Blink)
    RegWrite, REG_SZ, HKCU, Control Panel\Desktop, CursorBlinkRate, %Blink%
    Beep()
}
