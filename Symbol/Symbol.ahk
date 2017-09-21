; --------------------------------------------------------------------
; 特殊符號快速鍵
; --------------------------------------------------------------------
#Include, SymbolString.ahk

_Symbol:

    SetTitleMatchMode, RegEx

    ; 應用程式設定
    App =
    (c
        - EmEditor$ ahk_class ^EmEditorMainFrame3$                              ; EmEditor
        ahk_class ^(ENMainFrame|ENSingleNoteView)$                              ; Evernote
        ^MadEdit - \[.*\] $ ahk_class ^wxWindowClassNR$                         ; MadEdit
        ahk_class ^HwndWrapper\[MarkdownPad2                                    ; MarkdownPad
        ahk_class ^Notepad$                                                     ; Notepad
        - Microsoft Office OneNote$ ahk_class ^Framework::CFrame$               ; OneNote 2007
        ahk_class ^rctrl_renwnd32$                                              ; Outlook 2007
        ahk_class ^PCMan$                                                       ; PCMan
        ahk_class ^PieTTY$                                                      ; PieTTY
        \.:\. Rainlendar ahk_class ^wxWindowNR$                                 ; Rainlendar
        ahk_class ^SciTEWindow$                                                 ; SciTE
        ahk_class ^tSkMainForm$                                                 ; Skype
        UltraEdit - \[.*\]$| - UltraEdit$ ahk_class ^Afx(:[[:xdigit:]]+){5}$    ; UltraEdit
        ahk_class ^HwndWrapper\[DefaultDomain                                   ; Visual Studio 2010
        ^WinMerge - \[.*\]$ ahk_class ^WinMergeWindowClassW$                    ; WinMerge
        - Microsoft Word$ ahk_class ^OpusApp$                                   ; Word 2007
    )
    StringSplit, App, App, `n

    ; 快速鍵設定
    SetKeyLabel("!1", "Alt1")
    SetKeyLabel("!2", "Alt2")
    SetKeyLabel("!3", "Alt3")
    SetKeyLabel("!4", "Alt4")
    SetKeyLabel("!5", "Alt5")
    SetKeyLabel("!6", "Alt6")
    SetKeyLabel("!7", "Alt7")
    SetKeyLabel("!8", "Alt8")
    SetKeyLabel("!9", "Alt9")
    SetKeyLabel("!0", "Alt0")
    SetKeyLabel("!-", "Alt-")
    SetKeyLabel("!=", "Alt=")
    SetKeyLabel("!\", "Alt\")
    SetKeyLabel("!Q", "AltQ")
    SetKeyLabel("!W", "AltW")
    SetKeyLabel("!E", "AltE")
    SetKeyLabel("!R", "AltR")
    SetKeyLabel("!T", "AltT")
    SetKeyLabel("!Y", "AltY")
    SetKeyLabel("!U", "AltU")
    SetKeyLabel("!I", "AltI")
    SetKeyLabel("!O", "AltO")
    SetKeyLabel("!P", "AltP")
    SetKeyLabel("![", "Alt[")
    SetKeyLabel("!]", "Alt]")
    SetKeyLabel("!A", "AltA")
    SetKeyLabel("!S", "AltS")
    SetKeyLabel("!D", "AltD")
    SetKeyLabel("!F", "AltF")
    SetKeyLabel("!G", "AltG")
    SetKeyLabel("!H", "AltH")
    SetKeyLabel("!J", "AltJ")
    SetKeyLabel("!K", "AltK")
    SetKeyLabel("!L", "AltL")
    SetKeyLabel("!;", "Alt;")
    SetKeyLabel("!'", "Alt'")
    SetKeyLabel("!Z", "AltZ")
    SetKeyLabel("!X", "AltX")
    SetKeyLabel("!C", "AltC")
    SetKeyLabel("!V", "AltV")
    SetKeyLabel("!B", "AltB")
    SetKeyLabel("!N", "AltN")
    SetKeyLabel("!M", "AltM")
    SetKeyLabel("!,", "AltComma")
    SetKeyLabel("!.", "Alt.")
    SetKeyLabel("!/", "Alt/")
    Return

; --------------------------------------------------------------------
; 設定特殊符號快速鍵
; --------------------------------------------------------------------
SetKeyLabel(KeyName, KeyLabel)
{
    global
    Loop, %App0%
    {
        Hotkey, IfWinActive, % App%A_Index%
        Hotkey, %KeyName%, %KeyLabel%
    }
}
