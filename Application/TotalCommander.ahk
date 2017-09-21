; --------------------------------------------------------------------
; Total Commander
;
; Ctrl + 1                複製工作路徑 (單數)
; Ctrl + 2                複製檔案路徑 (複數)
; Ctrl + 3                複製檔案名稱 (複數)
; Ctrl + 4                複製檔案名稱 (包含副檔名) (複數)
; Ctrl + 5                如果檔案名稱最左邊包含一對括號，複製其中的文字 (複數)
; Ctrl + 6                如果檔案名稱最右邊包含一對括號，複製其中的文字 (複數)
; --------------------------------------------------------------------
#IfWinActive, ^(\[\d+\] )?Total Commander ahk_class ^TTOTAL_CMD$

^1::TotalCommander_CopyWorkingPath()
^2::TotalCommander_CopyFilePath()
^3::TotalCommander_CopyFileName()
^4::TotalCommander_CopyFileNameExt()
^5::TotalCommander_CopyBrace_L()
^6::TotalCommander_CopyBrace_R()

#IfWinActive

; --------------------------------------------------------------------
; 複製工作路徑
; --------------------------------------------------------------------
TotalCommander_CopyWorkingPath()
{
    ; 取得命令列左側的工作路徑
    ControlGetText, Path, TMyPanel3
    If (ErrorLevel)
    {
        Return
    }

    ; 將工作路徑的提示符號「>」改成「\」
    ; 將磁碟代號由英文小寫改成英文大寫
    StringReplace, Path, Path, >, \
    Path := RegExReplace(Path, "([a-zA-Z]):\\", "$u1:\")

    ; 複製到剪貼簿
    Clipboard := Path
}

; --------------------------------------------------------------------
; 複製檔案路徑
; --------------------------------------------------------------------
TotalCommander_CopyFilePath()
{
    ; 若視窗焦點不在檔案列表上
    ControlGetFocus, Control
    If (not RegExMatch(Control, "^TMyListBox"))
    {
        Return
    }

    ; [Mark]→[Copy Names With Path To Clipboard]
    Clipboard := ""
    WinMenuSelectItem,,, 2&, 14&
    ClipWait, 0
    If (ErrorLevel)
    {
        Return
    }

    ; 將磁碟代號由英文小寫改成英文大寫
    Path := Clipboard
    Path := RegExReplace(Path, "([a-zA-Z]):\\", "$u1:\")

    ; 複製到剪貼簿
    Clipboard := Path
}

; --------------------------------------------------------------------
; 複製檔案名稱
; --------------------------------------------------------------------
TotalCommander_CopyFileName()
{
    ; 若視窗焦點不在檔案列表上
    ControlGetFocus, Control
    If (not RegExMatch(Control, "^TMyListBox"))
    {
        Return
    }

    ; [Mark]→[Copy Selected Names To Clipboard]
    Clipboard := ""
    WinMenuSelectItem,,, 2&, 13&
    ClipWait, 0
    If (ErrorLevel)
    {
        Return
    }

    ; 若檔案名稱為資料夾，將「\」全部移除
    Name := Clipboard
    StringReplace, Name, Name, \,, All

    ; 若檔案名稱有副檔名 (1~7 英數字串)，將全部移除
    Name := RegExReplace(Name, "m)\.\w{1,7}$")

    ; 複製到剪貼簿
    Clipboard := Name
}

; --------------------------------------------------------------------
; 複製檔案名稱 (包含副檔名)
; --------------------------------------------------------------------
TotalCommander_CopyFileNameExt()
{
    ; 若視窗焦點不在檔案列表上
    ControlGetFocus, Control
    If (not RegExMatch(Control, "^TMyListBox"))
    {
        Return
    }

    ; [Mark]→[Copy Selected Names To Clipboard]
    Clipboard := ""
    WinMenuSelectItem,,, 2&, 13&
    ClipWait, 0
    If (ErrorLevel)
    {
        Return
    }

    ; 若檔案名稱為資料夾，將「\」全部移除
    Name := Clipboard
    StringReplace, Name, Name, \,, All

    ; 複製到剪貼簿
    Clipboard := Name
}

; --------------------------------------------------------------------
; 如果檔案名稱最左邊包含一對括號，複製其中的文字
; --------------------------------------------------------------------
TotalCommander_CopyBrace_L()
{
    ; 若視窗焦點不在檔案列表上
    ControlGetFocus, Control
    If (not RegExMatch(Control, "^TMyListBox"))
    {
        Return
    }

    ; [Mark]→[Copy Selected Names To Clipboard]
    Clipboard := ""
    WinMenuSelectItem,,, 2&, 13&
    ClipWait, 0
    If (ErrorLevel)
    {
        Return
    }

    ; 若檔案名稱為資料夾，將「\」全部移除
    Name := Clipboard
    StringReplace, Name, Name, \,, All

    ; 搜尋檔案名稱最左邊是否包含括號，並且將不包含的改成空行
    Name := RegExReplace(Name, "m)^(\((.*?)\)|\[(.*?)\]|[^(\[]).*$", "$2$3")

    ; 移除空行
    StringSplit, Name, Name, `r`n
    Loop, %Name0%
    {
        NameTemp := Name%A_Index%
        If (NameTemp = "")
        {
            Continue
        }

        NamePaste .= NameTemp "`r`n"
    }

    ; 複製到剪貼簿
    Clipboard := NamePaste
}

; --------------------------------------------------------------------
; 如果檔案名稱最右邊包含一對括號，複製其中的文字
; --------------------------------------------------------------------
TotalCommander_CopyBrace_R()
{
    ; 若視窗焦點不在檔案列表上
    ControlGetFocus, Control
    If (not RegExMatch(Control, "^TMyListBox"))
    {
        Return
    }

    ; [Mark]→[Copy Selected Names To Clipboard]
    Clipboard := ""
    WinMenuSelectItem,,, 2&, 13&
    ClipWait, 0
    If (ErrorLevel)
    {
        Return
    }

    ; 若檔案名稱為資料夾，將「\」全部移除
    Name := Clipboard
    StringReplace, Name, Name, \,, All

    ; 若檔案名稱有副檔名 (1~7 英數字串)，將全部移除
    Name := RegExReplace(Name, "m)\.\w{1,7}$")

    ; 搜尋檔案名稱最右邊是否包含括號，並且將不包含的改成空行
    Name := RegExReplace(Name, "m)^.*(\((.*?)\)|\[(.*?)\]|[^)\]])$", "$2$3")

    ; 移除空行
    StringSplit, Name, Name, `r`n
    Loop, %Name0%
    {
        NameTemp := Name%A_Index%
        If (NameTemp = "")
        {
            Continue
        }

        NamePaste .= NameTemp "`r`n"
    }

    ; 複製到剪貼簿
    Clipboard := NamePaste
}
