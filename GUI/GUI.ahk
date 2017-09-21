; --------------------------------------------------------------------
; GUI
; --------------------------------------------------------------------
_GUI:
#Include, HelpText.ahk

; ---- 設定圖示 ------------------------------------------------------

    hModule := DllCall("GetModuleHandle", UInt, 0)
    hIcon0 := DllCall("LoadImage", UInt, hModule, UInt, 159
        , UInt, 1, Int, 16, Int, 16, UInt, 0x8000)
    hIcon1 := DllCall("LoadImage", UInt, hModule, UInt, 159
        , UInt, 1, Int, 32, Int, 32, UInt, 0x8000)

; ---- 設定系統列 ----------------------------------------------------

    Menu, Tray, NoStandard
    Menu, Tray, Add, 關於 (&A), About
    Menu, Tray, Add, 說明 (&H), Help
    Menu, Tray, Add
    Menu, Tray, Add, 停用 (&D), Suspend
    Menu, Tray, Add
    Menu, Tray, Add, 結束 (&X), Exit
    Menu, Tray, Default, 停用 (&D)
    Menu, Tray, Tip, %ProductName%
    Menu, Tray, Icon, %A_ScriptFullPath%, 3

; ---- GUI: About ----------------------------------------------------

    Gui, About: Default
    Gui, +LastFound
    ; WM_SETICON = 0x80, ICON_SMALL = 0
    SendMessage, 0x80, 0, hIcon0
    ; WM_SETICON = 0x80, ICON_BIG = 1
    SendMessage, 0x80, 1, hIcon1
    Gui, Margin, 10, 10
    Gui, Add, Pic, ym+10, %A_ScriptFullPath%
    Gui, Add, Text, ym, % ""
        . ProductName " " ProductVersion "`n`n"
        . LegalCopyright "`n"
        . ContactAuthor
    Gui, Add, Button, x102 w70 Default gAboutGuiEscape, OK

; ---- GUI: Help -----------------------------------------------------

    Gui, Help: Default
    Gui, +HwndHelp +LastFound
    ; WM_SETICON = 0x80, ICON_SMALL = 0
    SendMessage, 0x80, 0, hIcon0
    ; WM_SETICON = 0x80, ICON_BIG = 1
    SendMessage, 0x80, 1, hIcon1
    Gui, Margin, 10, 10

    Gui, Font, s9, 新細明體
    Gui, Add, Tab2, w625 h435 +Theme -Background, 全域快速鍵|應用程式快速鍵|特殊符號快速鍵|快速字串|執行參數

    ; 全域快速鍵
    Gui, Font, s12, 細明體
    Gui, Add, Edit, w600 h390 ReadOnly HwndHelpEdit1 vHelpEdit1, %HelpText1%
    HelpText1 := ""

    ; 應用程式快速鍵
    Gui, Tab, 2
    Gui, Add, Edit, w600 h390 ReadOnly HwndHelpEdit2 vHelpEdit2, %HelpText2%
    HelpText2 := ""

    ; 特殊符號快速鍵
    Gui, Tab, 3
    Gui, Add, Edit, w600 h390 ReadOnly HwndHelpEdit3 vHelpEdit3, %HelpText3%
    HelpText3 := ""

    ; 快速字串
    Gui, Tab, 4
    Gui, Add, Edit, w600 h390 ReadOnly HwndHelpEdit4 vHelpEdit4, %HelpText4%
    HelpText4 := ""

    ; 執行參數
    Gui, Tab, 5
    Gui, Add, Edit, w600 h390 ReadOnly HwndHelpEdit5 vHelpEdit5, %HelpText5%
    HelpText5 := ""

    ; 取消 HelpEdit1 選取全部文字的狀態
    Gui, Tab
    GuiControl, Focus, HelpEdit1

; ---- GUI: Calendar -------------------------------------------------

    CalendarFormat =
    (
        yyyy-MM-dd dddd
        yyyy/M/d dddd
        yyyy 年 M 月 d 日 dddd
        ddd, MMM d, yyyy
        dddd, MMMM d, yyyy
        ddd, d MMM, yyyy
        dddd, d MMMM, yyyy
        yyyy-MM-dd dddd
        yyyy/M/d dddd
        yyyy 年 M 月 d 日 dddd
    )
    StringSplit, CalendarFormat, CalendarFormat, `n

    CalendarLocale =
    (
        L0x0404
        L0x0404
        L0x0404
        L0x0409
        L0x0409
        L0x0409
        L0x0409
        L0x0411
        L0x0411
        L0x0411
    )
    StringSplit, CalendarLocale, CalendarLocale, `n

    Gui, Calendar: Default
    Gui, +LastFound
    ; WM_SETICON = 0x80, ICON_SMALL = 0
    SendMessage, 0x80, 0, hIcon0
    ; WM_SETICON = 0x80, ICON_BIG = 1
    SendMessage, 0x80, 1, hIcon1
    Gui, Margin, 10, 10
    Gui, Add, MonthCal, vCalendar gCalendar_Update AltSubmit
    Gui, Add, ListView, xm r%CalendarFormat0% -Hdr -Multi NoSort gCalendar_Copy1, CalendarDate
    Gui, Add, Button, Default Hidden gCalendar_Copy2
    Loop, %CalendarFormat0%
    {
        LV_Add()
    }
    LV_Modify(1, "Focus Select")
    Gosub, Calendar_Update

; ---- GUI: Mouse OSD ------------------------------------------------

    Gui, Mouse_OSD: Default
    Gui, Color, 000000
    Gui, +AlwaysOnTop -Caption +Disabled +LastFound +ToolWindow
    WinSet, TransColor, 000000
    Gui, Font, cAqua s24 bold, MS Sans Serif
    Gui, Add, Text, x20 y0 w240 vMouseSensitivityText
    Gui, Font, cLime
    Gui, Add, Text, y+ w240 vMouseAccelerationText
    Gui, Add, Text, y+ w240 vMouseClickLockText

; ---- GUI: Sound OSD ------------------------------------------------

    Gui, Sound_OSD: Default
    Gui, Color, 000000
    Gui, +AlwaysOnTop -Caption +Disabled +LastFound +ToolWindow
    WinSet, TransColor, 000000
    Gui, Font, cLime s24 bold, MS Sans Serif
    Gui, Add, Text, x20 y0 w230 vMasterText

; ---- 結束返回 ------------------------------------------------------

    Return

; --------------------------------------------------------------------
; 系統列
; --------------------------------------------------------------------
#p::
Suspend:
    Suspend, Permit
    Suspend, Toggle
    If (A_IsSuspended)
    {
        Menu, Tray, Rename, 停用 (&D), 啟用 (&E)
    }
    Else
    {
        Menu, Tray, Rename, 啟用 (&E), 停用 (&D)
    }
    Return

; --------------------------------------------------------------------
; About
; --------------------------------------------------------------------
; 關於
About:
    Gui, About: Default
    Gui, Show, AutoSize Center, 關於 %ProductName%
    Return

; --------------------------------------------------------------------
; Help
; --------------------------------------------------------------------
; 說明
Help:
    Gui, Help: Default
    Gui, Show, AutoSize Center, %ProductName%
    Return

; --------------------------------------------------------------------
; Calendar
; --------------------------------------------------------------------
Calendar:
    Gui, Calendar: Default
    Gui, Show, AutoSize Center, Calendar
    Return

Calendar_Update:
    Calendar_Update()
    Return

Calendar_Copy1:
    Calendar_Copy1()
    Return

Calendar_Copy2:
    Calendar_Copy2()
    Return

Calendar_Update()
{
    global Calendar
    Count := CalendarFormat%A_IsCritical%
    Loop, %Count%
    {
        FormatTime, CalendarDate%A_Index%
            , % Calendar " " CalendarLocale%A_Index%
            , % CalendarFormat%A_Index%
        LV_Modify(A_Index, "", CalendarDate%A_Index%)
    }
}

Calendar_Copy1()
{
    If (A_GuiEvent = DoubleClick)
    {
        LV_GetText(Text, A_EventInfo)
        Clipboard := Text
        Gui, Calendar: Default
        Gui, Hide
    }
}

Calendar_Copy2()
{
    Index := LV_GetNext(0, "Focused")
    LV_GetText(Text, Index)
    Clipboard := Text
    Gui, Calendar: Default
    Gui, Hide
}

; --------------------------------------------------------------------
; Mouse OSD
; --------------------------------------------------------------------
Mouse_OSD:
    Mouse_OSD()
    Return

Mouse_OSD_Update:
    Mouse_OSD_Update()
    Return

Mouse_OSD_Off:
    Mouse_OSD_Off()
    Return

Mouse_OSD()
{
    Gui, Mouse_OSD: Default
    Gosub, Mouse_OSD_Update
    SetTimer, Mouse_OSD_Update, 100
    Gui, Show, x0 y0 AutoSize NoActivate
    SetTimer, Mouse_OSD_Off, 2000
}

Mouse_OSD_Update()
{
    Gui, Mouse_OSD: Default
    Gui, +AlwaysOnTop
    MouseSensitivity  := GetMouseSensitivity()
    MouseAcceleration := GetMouseAcceleration()
    MouseClickLock    := GetMouseClickLock()
    If (MouseAcceleration = "0 0 0")
    {
        Gui, Font, cRed
    }
    Else
    {
        Gui, Font, cLime
    }
    GuiControl, Font, MouseAccelerationText
    If (MouseClickLock)
    {
        MouseClickLock := "On"
        Gui, Font, cLime
    }
    Else
    {
        MouseClickLock := "Off"
        Gui, Font, cRed
    }
    GuiControl, Font, MouseClickLockText
    GuiControl,, MouseSensitivityText, % "滑鼠速度`t" MouseSensitivity
    GuiControl,, MouseAccelerationText, % "滑鼠加速`t" MouseAcceleration
    GuiControl,, MouseClickLockText, % "點選鎖定`t" MouseClickLock
}

Mouse_OSD_Off()
{
    Gui, Mouse_OSD: Default
    SetTimer, Mouse_OSD_Off, Off
    SetTimer, Mouse_OSD_Update, Off
    Gui, Hide
}

; --------------------------------------------------------------------
; Sound OSD
; --------------------------------------------------------------------
Sound_OSD:
    Sound_OSD()
    Return

Sound_OSD_Update:
    Sound_OSD_Update()
    Return

Sound_OSD_Off:
    Sound_OSD_Off()
    Return

Sound_OSD()
{
    Gui, Sound_OSD: Default
    Gosub, Sound_OSD_Update
    SetTimer, Sound_OSD_Update, 100
    SysGet, MonitorWorkArea, MonitorWorkArea
    X := MonitorWorkAreaRight - 280 ; 減去 OSD 視窗寬度
    Gui, Show, x%X% y0 AutoSize NoActivate
    SetTimer, Sound_OSD_Off, 2000
}

Sound_OSD_Update()
{
    Gui, Sound_OSD: Default
    Gui, +AlwaysOnTop
    ; 取得 Master 音量大小
    SoundGet, MasterVolume
    ; 將浮點數轉為整數
    MasterVolume := Round(MasterVolume)

    SoundGet, MasterMute, MASTER, MUTE
    ; 若 Master 設為靜音
    If (MasterMute = "On")
    {
        Gui, Font, cRed
    }
    Else
    {
        Gui, Font, cLime
    }
    GuiControl, Font, MasterText

    ; 更新 OSD 文字
    GuiControl,, MasterText, % "Volume`t" MasterVolume "%"
}

Sound_OSD_Off()
{
    Gui, Sound_OSD: Default
    SetTimer, Sound_OSD_Off, Off
    SetTimer, Sound_OSD_Update, Off
    Gui, Hide
}

; --------------------------------------------------------------------
; 其他
; --------------------------------------------------------------------
; 關閉 GUI
AboutGuiEscape:
HelpGuiEscape:
CalendarGuiEscape:
    Gui, Hide
    Return

; 結束程式
Exit:
    ExitApp
