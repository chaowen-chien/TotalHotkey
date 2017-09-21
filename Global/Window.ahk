; --------------------------------------------------------------------
; 視窗控制
;
; Win + Numpad0           視窗大小設為桌面大小並最大化
; Win + Numpad1           視窗位置移至桌面左下方
; Win + Numpad2           視窗位置移至桌面下方
; Win + Numpad3           視窗位置移至桌面右下方
; Win + Numpad4           視窗位置移至桌面左方
; Win + Numpad5           視窗位置移至桌面中央
; Win + Numpad6           視窗位置移至桌面右方
; Win + Numpad7           視窗位置移至桌面左上方
; Win + Numpad8           視窗位置移至桌面下方
; Win + Numpad9           視窗位置移至桌面右下方
; Ctrl + Win + Numpad0    視窗大小設為桌面大小
; Ctrl + Win + Numpad1    視窗大小設為 320x240
; Ctrl + Win + Numpad2    視窗大小設為 640x480
; Ctrl + Win + Numpad3    視窗大小設為 800x600
; Ctrl + Win + Numpad4    視窗大小設為 1024x768
; Ctrl + Win + Numpad5    視窗大小設為 1280x1024
; Ctrl + Win + Numpad6    視窗大小設為 1600x1200
; Ctrl + Win + Numpad7    視窗比例設為桌面的 1/4
; Ctrl + Win + Numpad8    視窗比例設為桌面的 1/2
; Ctrl + Win + Numpad9    視窗比例設為桌面的 4/5
; Win + Up                視窗 [最大化／還原]
; Win + Down              視窗最小化
; Ctrl + Win + Left       視窗水平並排
; Ctrl + Win + Right      視窗垂直並排
; Ctrl + Win + Up         視窗重疊顯示
; Ctrl + Win + Down       所有視窗最大化
; Win + PageUp            視窗設為最上層顯示
; Win + PageDown          視窗取消最上層顯示
; Alt + Win + Numpad0     取消視窗透明化
; Alt + Win + Numpad1     視窗透明度 10%
; Alt + Win + Numpad2     視窗透明度 20%
; Alt + Win + Numpad3     視窗透明度 30%
; Alt + Win + Numpad4     視窗透明度 40%
; Alt + Win + Numpad5     視窗透明度 50%
; Alt + Win + Numpad6     視窗透明度 60%
; Alt + Win + Numpad7     視窗透明度 70%
; Alt + Win + Numpad8     視窗透明度 80%
; Alt + Win + Numpad9     視窗透明度 90%
; --------------------------------------------------------------------
#Numpad0::
    WinSizeMaxA()
    WinMaximizeRestoreA()
    Return
#Numpad1::WinMoveA(1)
#Numpad2::WinMoveA(2)
#Numpad3::WinMoveA(3)
#Numpad4::WinMoveA(4)
#Numpad5::WinMoveA(5)
#Numpad6::WinMoveA(6)
#Numpad7::WinMoveA(7)
#Numpad8::WinMoveA(8)
#Numpad9::WinMoveA(9)
^#Numpad0::WinSizeMaxA()
^#Numpad1::WinSizeA( 320,  240)
^#Numpad2::WinSizeA( 640,  480)
^#Numpad3::WinSizeA( 800,  600)
^#Numpad4::WinSizeA(1024,  768)
^#Numpad5::WinSizeA(1280, 1024)
^#Numpad6::WinSizeA(1600, 1200)
^#Numpad7::WinScaleA(1, 4)
^#Numpad8::WinScaleA(1, 2)
^#Numpad9::WinScaleA(4, 5)
!#Numpad0::WinSetTransparent(255)
!#Numpad1::WinSetTransparent(225)
!#Numpad2::WinSetTransparent(200)
!#Numpad3::WinSetTransparent(175)
!#Numpad4::WinSetTransparent(150)
!#Numpad5::WinSetTransparent(125)
!#Numpad6::WinSetTransparent(100)
!#Numpad7::WinSetTransparent( 75)
!#Numpad8::WinSetTransparent( 50)
!#Numpad9::WinSetTransparent( 25)
#Up::   WinMaximizeRestoreA()
#Down:: WinMinimizeA()
^#Left:: TileWindows_Horizontal()
^#Right::TileWindows_Vertical()
^#Up::   CascadeWindows()
^#Down:: WinMaximizeAll()
#PgUp::   WinSetAlwaysOnTop_On()
#PgDn:: WinSetAlwaysOnTop_Off()

; --------------------------------------------------------------------
; 視窗重疊顯示
; --------------------------------------------------------------------
CascadeWindows()
{
    ; hwndParent = 0 (Desktop Window)
    ; wHow       = MDITILE_ZORDER = 4
    ; lpRect     = 0
    ; cKids      = 0
    ; lpKids     = 0
    DllCall("CascadeWindows", UInt, 0, UInt, 4, UInt, 0, UInt, 0, UInt, 0)
}

; --------------------------------------------------------------------
; 視窗水平並排
; --------------------------------------------------------------------
TileWindows_Horizontal()
{
    ; hwndParent = 0 (Desktop Window)
    ; wHow       = MDITILE_HORIZONTAL = 1
    ; lpRect     = 0
    ; cKids      = 0
    ; lpKids     = 0
    DllCall("TileWindows", UInt, 0, UInt, 1, UInt, 0, UInt, 0, UInt, 0)
}

; --------------------------------------------------------------------
; 視窗垂直並排
; --------------------------------------------------------------------
TileWindows_Vertical()
{
    ; hwndParent = 0 (Desktop Window)
    ; wHow       = MDITILE_VERTICAL = 0
    ; lpRect     = 0
    ; cKids      = 0
    ; lpKids     = 0
    DllCall("TileWindows", UInt, 0, UInt, 0, UInt, 0, UInt, 0, UInt, 0)
}

; --------------------------------------------------------------------
; 所有視窗最大化
; --------------------------------------------------------------------
WinMaximizeAll()
{
    WinGet, List, List
    Loop, %List%
    {
        Hwnd := List%A_Index%
        WinGet, Style, Style, ahk_id %Hwnd%
        ; WS_MAXIMIZEBOX = 0x10000
        If (Style & 0x10000)
        {
            ; WM_SYSCOMMAND = 0x112, SC_MAXIMIZE = 0xF030
            SendMessage, 0x112, 0xF030,,, ahk_id %Hwnd%
        }
    }
}

; --------------------------------------------------------------------
; 視窗 [最大化／還原]
; --------------------------------------------------------------------
WinMaximizeRestoreA()
{
    WinExist("A")
    WinGet, MinMax, MinMax
    If (MinMax = 1)
    {
        WinRestore
        Return
    }

    WinGet, Style, Style
    ; WS_MAXIMIZEBOX = 0x10000
    If (Style & 0x10000)
    {
        ; WM_SYSCOMMAND = 0x112, SC_MAXIMIZE = 0xF030
        SendMessage, 0x112, 0xF030
    }
}

; --------------------------------------------------------------------
; 視窗最小化
; --------------------------------------------------------------------
WinMinimizeA()
{
    WinExist("A")
    WinGet, Style, Style
    ; WS_MINIMIZEBOX = 0x20000
    If (Style & 0x20000)
    {
        ; WM_SYSCOMMAND = 0x112, SC_MINIMIZE = 0xF020
        SendMessage, 0x112, 0xF020,,, A
    }
}

; --------------------------------------------------------------------
; 設定視窗位置
; --------------------------------------------------------------------
WinMoveA(Pos)
{
    WinExist("A")
    WinRestore
    WinGetPos,,, Width, Height
    MonitorCurrent := GetMonitorNumber()
    SysGet, MonitorWorkArea, MonitorWorkArea, %MonitorCurrent%
    If (Pos = 1)
    {
        X := MonitorWorkAreaLeft
        Y := MonitorWorkAreaBottom - Height
    }
    Else If (Pos = 2)
    {
        X := (MonitorWorkAreaRight - Width + MonitorWorkAreaLeft) // 2
        Y := MonitorWorkAreaBottom - Height
    }
    Else If (Pos = 3)
    {
        X := MonitorWorkAreaRight - Width
        Y := MonitorWorkAreaBottom - Height
    }
    Else If (Pos = 4)
    {
        X := MonitorWorkAreaLeft
        Y := (MonitorWorkAreaBottom - Height + MonitorWorkAreaTop) // 2
    }
    Else If (Pos = 5)
    {
        X := (MonitorWorkAreaRight - Width + MonitorWorkAreaLeft) // 2
        Y := (MonitorWorkAreaBottom - Height + MonitorWorkAreaTop) // 2
    }
    Else If (Pos = 6)
    {
        X := MonitorWorkAreaRight - Width
        Y := (MonitorWorkAreaBottom - Height + MonitorWorkAreaTop) // 2
    }
    Else If (Pos = 7)
    {
        X := MonitorWorkAreaLeft
        Y := MonitorWorkAreaTop
    }
    Else If (Pos = 8)
    {
        X := (MonitorWorkAreaRight - Width + MonitorWorkAreaLeft) // 2
        Y := MonitorWorkAreaTop
    }
    Else If (Pos = 9)
    {
        X := MonitorWorkAreaRight - Width
        Y := MonitorWorkAreaTop
    }
    X := X < MonitorWorkAreaLeft ? MonitorWorkAreaLeft : X
    Y := Y < MonitorWorkAreaTop ? MonitorWorkAreaTop : Y
    WinMove,,, %X%, %Y%
}

; --------------------------------------------------------------------
; 設定視窗與桌面的比例
; --------------------------------------------------------------------
WinScaleA(Dividend, Divisor, Force = False)
{
    WinExist("A")
    WinGet, Style, Style
    ; WS_THICKFRAME = 0x40000
    If (not (Style & 0x40000) and (Force = False))
    {
        Return
    }
    WinRestore
    MonitorCurrent := GetMonitorNumber()
    SysGet, MonitorWorkArea, MonitorWorkArea, %MonitorCurrent%
    Width := (MonitorWorkAreaRight - MonitorWorkAreaLeft) // Divisor * Dividend
    Height := (MonitorWorkAreaBottom - MonitorWorkAreaTop) // Divisor * Dividend
    X := (MonitorWorkAreaRight - Width + MonitorWorkAreaLeft) // 2
    Y := (MonitorWorkAreaBottom - Height + MonitorWorkAreaTop) // 2
    WinMove,,, %X%, %Y%, %Width%, %Height%
}

; --------------------------------------------------------------------
; 設定視窗大小
; --------------------------------------------------------------------
WinSizeA(Width, Height, Force = False)
{
    WinExist("A")
    WinGet, Style, Style
    ; WS_THICKFRAME = 0x40000
    If (not (Style & 0x40000) and (Force = False))
    {
        Return
    }
    WinRestore
    MonitorCurrent := GetMonitorNumber()
    SysGet, MonitorWorkArea, MonitorWorkArea, %MonitorCurrent%
    X := (MonitorWorkAreaRight - Width + MonitorWorkAreaLeft) // 2
    Y := (MonitorWorkAreaBottom - Height + MonitorWorkAreaTop) // 2
    X := X < MonitorWorkAreaLeft ? MonitorWorkAreaLeft : X
    Y := Y < MonitorWorkAreaTop ? MonitorWorkAreaTop : Y
    WinMove,,, %X%, %Y%, %Width%, %Height%
}

; --------------------------------------------------------------------
; 設定視窗大小為桌面大小
; --------------------------------------------------------------------
WinSizeMaxA(Force = False)
{
    WinExist("A")
    WinGet, Style, Style
    ; WS_THICKFRAME = 0x40000
    If (not (Style & 0x40000) and (Force = False))
    {
        Return
    }
    WinRestore
    MonitorCurrent := GetMonitorNumber()
    SysGet, MonitorWorkArea, MonitorWorkArea, %MonitorCurrent%
    X := MonitorWorkAreaLeft
    Y := MonitorWorkAreaTop
    Width := MonitorWorkAreaRight - MonitorWorkAreaLeft
    Height := MonitorWorkAreaBottom - MonitorWorkAreaTop
    WinMove,,, %X%, %Y%, %Width%, %Height%
}

; --------------------------------------------------------------------
; 取得滑鼠游標位置的螢幕編號
; --------------------------------------------------------------------
GetMonitorNumber()
{
    MonitorNumber := 1
    SysGet, MonitorCount, MonitorCount
    Loop, %MonitorCount%
    {
        SysGet, Monitor, Monitor, %A_Index%
        MouseGetPos, X, Y
        If ((X >= MonitorLeft) and (X <= MonitorRight) and (Y >= MonitorTop) and (Y <= MonitorBottom))
        {
            MonitorNumber := A_Index
            Break
        }
    }
    Return, MonitorNumber
}

; --------------------------------------------------------------------
; 設定視窗最上層顯示
; --------------------------------------------------------------------
WinSetAlwaysOnTop_On()
{
    WinSet, AlwaysOnTop, On, A
    Beep()
}

; --------------------------------------------------------------------
; 取消視窗最上層顯示
; --------------------------------------------------------------------
WinSetAlwaysOnTop_Off()
{
    WinSet, AlwaysOnTop, Off, A
    Beep()
}

; --------------------------------------------------------------------
; 設定視窗透明化
; --------------------------------------------------------------------
WinSetTransparent(Transparent)
{
    If (Transparent = 255)
    {
        WinSet, Transparent, Off, A
    }
    Else
    {
        WinSet, Transparent, %Transparent%, A
    }
}
