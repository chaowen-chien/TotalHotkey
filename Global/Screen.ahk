; --------------------------------------------------------------------
; 螢幕保護
;
; Ctrl + Print Screen     啟動螢幕保護程式
; Shift + Print Screen    設定螢幕保護程式
; Win + Print Screen      關閉螢幕
; --------------------------------------------------------------------
^PrintScreen::ScreenSaver()
+PrintScreen::ScreenProperty()
#PrintScreen::ScreenOff()

; --------------------------------------------------------------------
; 執行螢幕保護程式
; --------------------------------------------------------------------
ScreenSaver()
{
    Sleep, 500
    BlockInput, On
    ; WM_SYSCOMMAND = 0x112, SC_SCREENSAVE = 0xF140
    SendMessage, 0x112, 0xF140, 0,, ahk_class ^Progman$
    Sleep, 1000
    While A_TimeIdlePhysical > 1000
    {
        Sleep, 100
    }
    BlockInput, Off
    SysGet, MonitorWorkArea, MonitorWorkArea
    X := MonitorWorkAreaRight // 2
    Y := MonitorWorkAreaBottom // 2
    MouseMove, 0, 0, 0
    MouseMove, %X%, %Y%, 0
}

; --------------------------------------------------------------------
; 設定螢幕保護程式
; --------------------------------------------------------------------
ScreenProperty()
{
    Run, rundll32.exe shell32.dll`,Control_RunDLL desk.cpl`,@0`,1
}

; --------------------------------------------------------------------
; 關閉螢幕電源
; --------------------------------------------------------------------
ScreenOff()
{
    Sleep, 500
    BlockInput, On
    ; WM_SYSCOMMAND = 0x112, SC_MONITORPOWER = 0xF170
    ; 1: 省電模式 2: 電源關閉
    SendMessage, 0x112, 0xF170, 2,, ahk_class ^Progman$
    Sleep, 1000
    While A_TimeIdlePhysical > 1000
    {
        Sleep, 100
    }
    BlockInput, Off
}
