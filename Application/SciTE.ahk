; --------------------------------------------------------------------
; SciTE
;
; Ctrl + C                複製／複製整行 (未選取文字時)
; Ctrl + X                剪下／剪下整行 (未選取文字時)
; Ctrl + E                刪除整行
; Ctrl + B                選取括號內文字
; Ctrl + Up               上一段落
; Ctrl + Down             下一段落
; Ctrl + 滑鼠左鍵         雙擊滑鼠左鍵
; Ctrl + 滑鼠中鍵         清除剪貼簿
; Ctrl + 滑鼠右鍵         貼上／刪除 (選取文字且剪貼簿沒有資料時)
; --------------------------------------------------------------------
#IfWinActive, ahk_class ^SciTEWindow$

^c::SciTE_CopyLine()
^x::SciTE_CutLine()
^e::SciTE_DeleteLine()
^b::SciTE_SelectToBrace()
^Up::SciTE_PreviousParagraph()
^Down::SciTE_NextParagraph()
^LButton::MouseDoubleClick()
^MButton::EmptyClipboard()
^RButton::SciTE_Paste()

#IfWinActive

; --------------------------------------------------------------------
; 複製／複製整行 (未選取文字時)
; --------------------------------------------------------------------
SciTE_CopyLine()
{
    ; TB_GETSTATE = WM_USER + 12 = 0x400 + 0x12 = 0x412
    ; wParam = idButton = 0xcc (Copy)
    SendMessage, 0x412, 0xcc,, ToolbarWindow321
    If (ErrorLevel = -1)
    {
        Return
    }

    ; TBSTATE_ENABLED = 4
    TextSelected := ErrorLevel & 4
    If (TextSelected)
    {
        Send, ^c
    }
    Else
    {
        Send, {End}{Home 2}{Shift Down}{End}{Right}{Shift Up}^c{Left}{Home 2}
    }
}

; --------------------------------------------------------------------
; 剪下／剪下整行 (未選取文字時)
; --------------------------------------------------------------------
SciTE_CutLine()
{
    ; TB_GETSTATE = WM_USER + 12 = 0x400 + 0x12 = 0x412
    ; wParam = idButton = 0xcb (Cut)
    SendMessage, 0x412, 0xcb,, ToolbarWindow321
    If (ErrorLevel = -1)
    {
        Return
    }

    ; TBSTATE_ENABLED = 4
    TextSelected := ErrorLevel & 4
    If (TextSelected)
    {
        Send, ^x
    }
    Else
    {
        Send, ^l
    }
}

; --------------------------------------------------------------------
; 刪除整行
; --------------------------------------------------------------------
SciTE_DeleteLine()
{
    Send, ^+l
}

; --------------------------------------------------------------------
; 選取括號內文字
; --------------------------------------------------------------------
SciTE_SelectToBrace()
{
    Send, ^+e
}

; --------------------------------------------------------------------
; 上一段落
; --------------------------------------------------------------------
SciTE_PreviousParagraph()
{
    Send, ^[
}

; --------------------------------------------------------------------
; 下一段落
; --------------------------------------------------------------------
SciTE_NextParagraph()
{
    Send, ^]
}

; --------------------------------------------------------------------
; 貼上／刪除 (選取文字且剪貼簿沒有資料時)
; --------------------------------------------------------------------
SciTE_Paste()
{
    Send, ^v
}
