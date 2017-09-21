; --------------------------------------------------------------------
; Notepad (記事本)
;
; Ctrl + C                複製／複製整行 (未選取文字時)
; Ctrl + X                剪下／剪下整行 (未選取文字時)
; Ctrl + E                刪除整行
; Ctrl + 滑鼠左鍵         雙擊滑鼠左鍵
; Ctrl + 滑鼠中鍵         清除剪貼簿
; Ctrl + 滑鼠右鍵         貼上／刪除 (選取文字且剪貼簿沒有資料時)
; --------------------------------------------------------------------
#IfWinActive, ahk_class ^Notepad$

^c::Notepad_CopyLine()
^x::Notepad_CutLine()
^e::Notepad_DeleteLine()
^LButton::MouseDoubleClick()
^MButton::EmptyClipboard()
^RButton::Notepad_Paste()

#IfWinActive

; --------------------------------------------------------------------
; 複製／複製整行 (未選取文字時)
; --------------------------------------------------------------------
Notepad_CopyLine()
{
    VarSetCapacity(wParam, 4)
    VarSetCapacity(lParam, 4)
    ; 取得選取文字的起點、終點
    ; EM_GETSEL = 0xB0
    SendMessage, 0xB0, &wParam, &lParam, Edit1
    If (ErrorLevel = -1)
    {
        Return
    }

    Pos1 := NumGet(wParam)
    Pos2 := NumGet(lParam)
    ; 若選取文字的起點與終點相同 (未選取文字)
    If (Pos1 = Pos2)
    {
        Send, {Home}{Shift Down}{End}{Right}{Shift Up}^c{Left}{Home}
    }
    Else
    {
        Send, ^c
    }
}

; --------------------------------------------------------------------
; 剪下／剪下整行 (未選取文字時)
; --------------------------------------------------------------------
Notepad_CutLine()
{
    VarSetCapacity(wParam, 4)
    VarSetCapacity(lParam, 4)
    ; 取得選取文字的起點、終點
    ; EM_GETSEL = 0xB0
    SendMessage, 0xB0, &wParam, &lParam, Edit1
    If (ErrorLevel = -1)
    {
        Return
    }

    Pos1 := NumGet(wParam)
    Pos2 := NumGet(lParam)
    ; 若選取文字的起點與終點相同 (未選取文字)
    If (Pos1 = Pos2)
    {
        Send, {Home}{Shift Down}{End}{Right}{Shift Up}^x
    }
    Else
    {
        Send, ^x
    }
}

; --------------------------------------------------------------------
; 刪除整行
; --------------------------------------------------------------------
Notepad_DeleteLine()
{
    Send, {Home}{Shift Down}{End}{Right}{Shift Up}{Del}
}

; --------------------------------------------------------------------
; 貼上／刪除 (選取文字且剪貼簿沒有資料時)
; --------------------------------------------------------------------
Notepad_Paste()
{
    If (Clipboard != "")
    {
        Send, ^v
        Return
    }

    VarSetCapacity(wParam, 4)
    VarSetCapacity(lParam, 4)
    ; 取得選取文字的起點、終點
    ; EM_GETSEL = 0xB0
    SendMessage, 0xB0, &wParam, &lParam, Edit1
    If (ErrorLevel = -1)
    {
        Return
    }

    Pos1 := NumGet(wParam)
    Pos2 := NumGet(lParam)
    ; 若選取文字的起點與終點不同 (已選取文字)
    If (Pos1 != Pos2)
    {
        Send, {Del}
    }
}
