; --------------------------------------------------------------------
; [啟動／切換] 應用程式
;
; Win + A                 小算盤
; Win + C                 命令提示字元
; Win + I                 Internet Explorer
; Win + J                 OneNote
; Win + K                 Mozilla Firefox
; Win + N                 記事本
; Win + O                 Outlook
; Win + Q                 小畫家
; Win + S                 foobar2000
; Win + T                 Total Commander
; Win + V                 UltraEdit
; Win + W                 Windows Live Mail
; Win + X                 EmEditor
; Win + Y                 Calendar (複製日期到剪貼簿)
; Win + Z                 資源回收筒
; --------------------------------------------------------------------
#a::Launch_Calc()
#c::Launch_CommandPrompt()
#i::Launch_InternetExplorer()
#j::Launch_OneNote()
#k::Launch_MozillaFirefox()
#n::Launch_Notepad()
#o::Launch_Outlook()
#q::Launch_MSPaint()
#s::Launch_foobar2000()
#t::Launch_TotalCommander()
#v::Launch_UltraEdit()
#w::Launch_WindowsLiveMail()
#x::Launch_EmEditor()
#y::Gosub, Calendar
#z::Launch_RecycleBin()

; --------------------------------------------------------------------
; 執行螢幕小鍵盤
; --------------------------------------------------------------------
Launch_Calc()
{
    IfWinExist, ahk_class ^CalcFrame|SciCalc$
    {
        WinActivate
        Return
    }

    IfExist, %A_WinDir%\system32\calc.exe
    {
        Run, calc.exe, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行命令提示字元
; --------------------------------------------------------------------
Launch_CommandPrompt()
{
    IfWinExist, ahk_class ^ConsoleWindowClass$
    {
        WinActivate
        Return
    }

    IfExist, %ComSpec%
    {
        Run, %ComSpec%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; EmEditor
; --------------------------------------------------------------------
Launch_EmEditor()
{
    IfWinExist, - EmEditor$ ahk_class ^EmEditorMainFrame3$
    {
        WinActivate
        Return
    }

    RegRead, EmEditor, HKLM, SOFTWARE\Classes\emeditor.jsee\shell\open\command
    If (ErrorLevel)
    {
        Return
    }

    EmEditor := RegExReplace(EmEditor, """(.*)"" ""%1""", "$1")
    IfExist, %EmEditor%
    {
        Run, %EmEditor%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行 foobar2000
; --------------------------------------------------------------------
Launch_foobar2000()
{
    RegRead, foobar2000, HKCR, foobar2000.MP3\shell\open\command
    If (ErrorLevel)
    {
        Return
    }

    foobar2000 := RegExReplace(foobar2000, """(.*)"" ""%1""", "$1")
    WinTitle := "^foobar2000 v1\.\d\.\d+$|\[foobar2000 v1\.\d\.\d+\]$ ahk_class ^{97E27FAA-C0B3-4b8e-A693-ED7881E99FC1}$"

    DetectHiddenWindows, On
    IfWinExist, %WinTitle%
    {
        WinGet, List, List
        Loop, %List%
        {
            Hwnd := List%A_Index%
            WinGet, ProcessPath, ProcessPath, ahk_id %Hwnd%
            If (ProcessPath = foobar2000)
            {
                WinActivate, ahk_id %Hwnd%
                Return
            }
        }
    }

    IfExist, %foobar2000%
    {
        Run, %foobar2000%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行 Internet Explorer
; --------------------------------------------------------------------
Launch_InternetExplorer()
{
    IfWinExist, ahk_class ^IEFrame$
    {
        WinActivate
        Return
    }

    RegRead, InternetExplorer, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\IEXPLORE.EXE
    If (ErrorLevel)
    {
        Return
    }

    IfExist, %InternetExplorer%
    {
        Run, %InternetExplorer%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行 Magic Mail Monitor
; --------------------------------------------------------------------
Launch_MagicMailMonitor()
{
    IfWinExist, - Magic Mail Monitor$ ahk_class ^Afx(:[[:xdigit:]]+){5}$
    {
        WinActivate
        Return
    }

    RegRead, MagicMailMonitor, HKCR, Magic.Document\shell\open\command
    If (ErrorLevel)
    {
        Return
    }

    StringReplace, MagicMailMonitor, MagicMailMonitor, % " ""`%1"""
    IfExist, %MagicMailMonitor%
    {
        Run, %MagicMailMonitor%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行 Mozilla Firefox
; --------------------------------------------------------------------
Launch_MozillaFirefox()
{
    IfWinExist, (^|- )Mozilla Firefox( \(隱私瀏覽\))?$|^Firefox - 分頁群組$ ahk_class ^MozillaWindowClass$
    {
        WinActivate
        Return
    }

    RegRead, MozillaFirefox, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe
    If (ErrorLevel)
    {
        Return
    }

    IfExist, %MozillaFirefox%
    {
        Run, %MozillaFirefox%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行小畫家
; --------------------------------------------------------------------
Launch_MSPaint()
{
    IfWinExist, ahk_class ^MSPaintApp$
    {
        WinActivate
        Return
    }

    IfExist, %A_WinDir%\system32\mspaint.exe
    {
        Run, mspaint.exe, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行記事本
; --------------------------------------------------------------------
Launch_Notepad()
{
    IfWinExist, ahk_class ^Notepad$
    {
        WinActivate
        Return
    }

    IfExist, %A_WinDir%\system32\notepad.exe
    {
        Run, notepad.exe, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行 OneNote
; --------------------------------------------------------------------
Launch_OneNote()
{
    IfWinExist, -( Microsoft Office)? OneNote$ ahk_class ^Framework::CFrame$
    {
        WinActivate
        Return
    }

    RegRead, OneNote, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\OneNote.exe
    If (ErrorLevel)
    {
        Return
    }

    IfExist, %OneNote%
    {
        Run, %OneNote%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行 Outlook
; --------------------------------------------------------------------
Launch_Outlook()
{
    IfWinExist, ahk_class ^rctrl_renwnd32$
    {
        WinActivate
        Return
    }

    RegRead, Outlook, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\OUTLOOK.EXE
    If (ErrorLevel)
    {
        Return
    }

    IfExist, %Outlook%
    {
        Run, %Outlook%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行資源回收筒
; --------------------------------------------------------------------
Launch_RecycleBin()
{
    IfWinExist, ^資源回收筒$ ahk_class ^CabinetWClass$
    {
        WinActivate
        Return
    }
    Run, ::{645ff040-5081-101b-9f08-00aa002f954e}
}

; --------------------------------------------------------------------
; 執行 Total Commander
; --------------------------------------------------------------------
Launch_TotalCommander()
{
    IfWinExist, ahk_class ^TTOTAL_CMD$
    {
        WinGet, PID, PID
        WinActivate, ahk_pid %PID%
        Return
    }

    IfWinExist, ahk_class ^TTOTAL_CMD$
    {
        WinActivate
        Return
    }

    RegRead, TotalCommanderDir, HKCU, Software\Ghisler\Total Commander, InstallDir
    If (ErrorLevel)
    {
        Return
    }

    IfExist, %TotalCommanderDir%\totalcmd.exe
    {
        Run, totalcmd.exe, %TotalCommanderDir%,, PID
        WinWait, ahk_pid %PID%,, 0
        If (ErrorLevel)
        {
            Return
        }

        WinActivate
    }
}

; --------------------------------------------------------------------
; 執行 UltraEdit
; --------------------------------------------------------------------
Launch_UltraEdit()
{
    DetectHiddenWindows, On
    IfWinExist, ^UltraEdit$|UltraEdit - \[.*\]$| - UltraEdit$ ahk_class ^Afx(:[[:xdigit:]]+){5}$
    {
        WinActivate
        WinGetTitle, Title
        ; 若尚未開啟任何檔案
        If (RegExMatch(Title, "^UltraEdit$"))
        {
            SendMessage, 0x111, 57600 ; File→New
        }
        Return
    }

    RegRead, UltraEdit, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\uedit32.exe
    If (ErrorLevel)
    {
        Return
    }

    IfExist, %UltraEdit%
    {
        Run, %UltraEdit%, %A_MyDocuments%
    }
}

; --------------------------------------------------------------------
; 執行 Windows Live Mail
; --------------------------------------------------------------------
Launch_WindowsLiveMail()
{
    IfWinExist, ahk_class ^Outlook Express Browser Class$
    {
        WinActivate
        Return
    }

    RegRead, WindowsLiveMail, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\wlmail.exe
    If (ErrorLevel)
    {
        Return
    }

    IfExist, %WindowsLiveMail%
    {
        Run, %WindowsLiveMail%, %A_MyDocuments%
    }
}
