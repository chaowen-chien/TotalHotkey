; --------------------------------------------------------------------
; 滑鼠設定
;
; Win + 滑鼠滾輪          滾輪向上：滑鼠速度增加 (+1)
;                         滾輪向下：滑鼠速度減少 (-1)
;                         滑鼠中鍵：啟用／停用滑鼠加速
; Ctrl + Win + 滑鼠滾輪   滾輪向上：滑鼠速度增加 (+5)
;                         滾輪向下：滑鼠速度減少 (-5)
;                         滑鼠中鍵：啟用／停用點選鎖定
; Win + 滑鼠左鍵          雙擊滑鼠左鍵
; Win + 滑鼠右鍵          上一頁 (模擬 Alt + Left)
; Win + [                 滑鼠速度減少
; Win + ]                 滑鼠速度增加
; Win + ,                 滑鼠游標移至螢幕右上方
; Win + .                 滑鼠游標移至桌面中央／切換多螢幕
; Win + /                 設定滑鼠游標位置
; Ctrl + Win + [          啟用／停用滑鼠加速
; Ctrl + Win + ]          啟用／停用點選鎖定
; --------------------------------------------------------------------
#WheelUp::AddMouseSensitivity()
#WheelDown::SubMouseSensitivity()
#MButton::ToggleMouseAcceleration()
^#WheelUp::AddMouseSensitivity(5)
^#WheelDown::SubMouseSensitivity(5)
^#MButton::ToggleMouseClickLock()
#LButton::MouseDoubleClick()
#RButton::Send, !{Left}
#[::SubMouseSensitivity()
#]::AddMouseSensitivity()
^#[::ToggleMouseAcceleration()
^#]::ToggleMouseClickLock()
#,::MouseMoveRightTop()
#.::MouseMoveCenter()
#/::MouseSetPos()

; --------------------------------------------------------------------
; 讀取滑鼠速度
; --------------------------------------------------------------------
GetMouseSensitivity()
{
    ; SPI_GETMOUSESPEED = 0x70
    DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UIntP, Sensitivity, UInt, 0)
    Return, Sensitivity
}

; --------------------------------------------------------------------
; 設定滑鼠速度
; --------------------------------------------------------------------
SetMouseSensitivity(Sensitivity)
{
    ; SPI_SETMOUSESPEED = 0x71
    DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, Sensitivity, UInt, 1)
}

; --------------------------------------------------------------------
; 增加滑鼠速度
; --------------------------------------------------------------------
AddMouseSensitivity(i = 1)
{
    Sensitivity := GetMouseSensitivity() + i
    If (Sensitivity > 20)
    {
        Sensitivity := 20
    }
    SetMouseSensitivity(Sensitivity)
    Gosub, Mouse_OSD
}

; --------------------------------------------------------------------
; 減少滑鼠速度
; --------------------------------------------------------------------
SubMouseSensitivity(i = 1)
{
    Sensitivity := GetMouseSensitivity() - i
    If (Sensitivity < 1)
    {
        Sensitivity := 1
    }
    SetMouseSensitivity(Sensitivity)
    Gosub, Mouse_OSD
}

; --------------------------------------------------------------------
; 讀取滑鼠加速
; --------------------------------------------------------------------
GetMouseAcceleration()
{
    ; SPI_GETMOUSE = 3
    VarSetCapacity(Acceleration, 12)
    DllCall("SystemParametersInfo", UInt, 3, UInt, 0, UInt, &Acceleration, UInt, 0)
    Threshold1 := NumGet(Acceleration, 0)
    Threshold2 := NumGet(Acceleration, 4)
    Speed      := NumGet(Acceleration, 8)
    Return, % Speed " " Threshold1 " " Threshold2
}

; --------------------------------------------------------------------
; 設定滑鼠加速
; --------------------------------------------------------------------
SetMouseAcceleration(Speed, Threshold1, Threshold2)
{
    ; SPI_SETMOUSE = 4
    VarSetCapacity(Acceleration, 12)
    NumPut(Threshold1, Acceleration, 0)
    NumPut(Threshold2, Acceleration, 4)
    NumPut(Speed,      Acceleration, 8)
    DllCall("SystemParametersInfo", UInt, 4, UInt, 0, UInt, &Acceleration, UInt, 1)
}

; --------------------------------------------------------------------
; 啟用／停用滑鼠加速
; --------------------------------------------------------------------
ToggleMouseAcceleration()
{
    If (GetMouseAcceleration() = "0 0 0")
    {
        SetMouseAcceleration(1, 6, 10)
    }
    Else
    {
        SetMouseAcceleration(0, 0, 0)
    }
    Gosub, Mouse_OSD
}

; --------------------------------------------------------------------
; 讀取滑鼠點選鎖定
; --------------------------------------------------------------------
GetMouseClickLock()
{
    ; SPI_GETMOUSECLICKLOCK = 0x101E
    DllCall("SystemParametersInfo", UInt, 0x101E, UInt, 0, UIntP, ClickLock, UInt, 0)
    Return, ClickLock
}

; --------------------------------------------------------------------
; 設定滑鼠點選鎖定
; --------------------------------------------------------------------
SetMouseClickLock(ClickLock)
{
    If (ClickLock)
    {
        ; SPI_SETMOUSECLICKLOCK = 0x101F
        ; HKCU\Control Panel\Desktop, UserPreferencesMask = B0920280
        DllCall("SystemParametersInfo", UInt, 0x101F, UInt, 0, UInt, 1, UInt, 1)

        ; SPI_SETMOUSECLICKLOCKTIME = 0x2009
        ; MouseClickLockTime = 200～2200ms (Default = 1200ms)
        ; HKCU\Control Panel\Desktop, ClickLockTime = 200
        DllCall("SystemParametersInfo", UInt, 0x2009, UInt, 0, UInt, 200, UInt, 1)
    }
    Else
    {
        ; SPI_SETMOUSECLICKLOCK = 0x101F
        ; HKCU\Control Panel\Desktop, UserPreferencesMask = B0120280
        DllCall("SystemParametersInfo", UInt, 0x101F, UInt, 0, UInt, 0, UInt, 1)
    }
}

; --------------------------------------------------------------------
; 啟用／停用滑鼠點選鎖定
; --------------------------------------------------------------------
ToggleMouseClickLock()
{
    If (GetMouseClickLock())
    {
        SetMouseClickLock(False)
    }
    Else
    {
        SetMouseClickLock(True)
    }
    Gosub, Mouse_OSD
}

; --------------------------------------------------------------------
; 雙擊滑鼠左鍵 (加上按鈕組態及點選鎖定檢查)
; --------------------------------------------------------------------
MouseDoubleClick()
{
    ; SPI_GETMOUSECLICKLOCK = 0x101E
    DllCall("SystemParametersInfo", UInt, 0x101E, UInt, 0, UIntP, ClickLock, UInt, 0)
    ; 若開啟點選鎖定
    If (ClickLock)
    {
        Click, 3
    }
    Else
    {
        Click, 2
    }
}

MouseDoubleClick2()
{
    ; SM_SWAPBUTTON = 23
    SwapButton := DllCall("GetSystemMetrics", UInt, 23)
    If (SwapButton)
    {
        ClickButton := "RButton"
    }
    Else
    {
        ClickButton := "LButton"
    }

    ; SPI_GETMOUSECLICKLOCK = 0x101E
    DllCall("SystemParametersInfo", UInt, 0x101E, UInt, 0, UIntP, ClickLock, UInt, 0)
    ; 若開啟點選鎖定
    If (ClickLock)
    {
        ClickCount := 3
    }
    Else
    {
        ClickCount := 2
    }

    Send, {%ClickButton% %ClickCount%}
}

; --------------------------------------------------------------------
; 滑鼠游標位置設為右上
; --------------------------------------------------------------------
MouseMoveRightTop()
{
    MouseMove, %A_ScreenWidth%, 0, 0
}

; --------------------------------------------------------------------
; 滑鼠游標位置設為中央／切換多螢幕
; --------------------------------------------------------------------
MouseMoveCenter()
{
    static MonitorCurrent := 0
    SysGet, MonitorCount, MonitorCount
    If (++MonitorCurrent > MonitorCount)
    {
        MonitorCurrent := 1
    }
    SysGet, MonitorWorkArea, MonitorWorkArea, %MonitorCurrent%
    X := (MonitorWorkAreaRight + MonitorWorkAreaLeft) // 2
    Y := (MonitorWorkAreaBottom + MonitorWorkAreaTop) // 2
    MouseMove, %X%, %Y%, 0
}

; --------------------------------------------------------------------
; 設定滑鼠游標位置
; --------------------------------------------------------------------
MouseSetPos()
{
    InputBox, X, 設定滑鼠游標位置, 請輸入座標 X,, 200, 120
    InputBox, Y, 設定滑鼠游標位置, 請輸入座標 Y,, 200, 120
    If (X is not Integer)
    {
        Return
    }
    If (Y is not Integer)
    {
        Return
    }
    MouseMove, %X%, %Y%, 0
}
