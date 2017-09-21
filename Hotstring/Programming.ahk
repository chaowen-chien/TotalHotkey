#Include, Line.ahk

; --------------------------------------------------------------------
; 分隔線 2
; --------------------------------------------------------------------
:://ll::
    SendString(CommentLine())
    Return

:://lt::
    SendString(CommentText())
    Return

:://tl::
    SendString(TitleLine())
    Return

:://tt::
    SendString(TitleText())
    Return

; --------------------------------------------------------------------
; Assembly、AutoHotkey、AutoIt 分隔線
; --------------------------------------------------------------------
:://al::
    SendString(CommentLine(";"))
    Return

:://at::
    SendString(CommentText(";"))
    Return

; --------------------------------------------------------------------
; C/C++/C#、Java/JavaScript/JScript 分隔線
; --------------------------------------------------------------------
:://cl::
    SendString(CommentLine("//"))
    Return

:://ct::
    SendString(CommentText("//"))
    Return

; --------------------------------------------------------------------
; Perl 分隔線
; --------------------------------------------------------------------
:://pl::
    SendString(CommentLine("#"))
    Return

:://pt::
    SendString(CommentText("#"))
    Return

; --------------------------------------------------------------------
; 轉換剪貼簿數字為 [十進制／十六進制]
; --------------------------------------------------------------------
:://.::
    CandidateList := ClipNum()
    CandidateWindow()
    Return

ClipNum()
{
    Number := Clipboard

    ; 移除換行字元、Tab 字元、首尾多餘空白
    StringReplace, Number, Number, `r`n
    StringReplace, Number, Number, % "`t", % " "
    Number := Trim(Number)

    ; 若數值不為整數
    If (Number is not Integer)
    {
        Return
    }

    ; 若數值小於 0
    If (Number < 0)
    {
        Return
    }

    ; 十進制數字
    SetFormat, Integer, D
    Number += 0
    String1 := Number "`n"

    ; 十六進制數字
    SetFormat, Integer, H
    Number += 0
    StringUpper, Number, Number
    Number := "0x" SubStr(Number, 3)
    String2 := Number

    ; 若十六進制數字的字串長度小於 6 (含 0x)
    If (StrLen(Number) < 6)
    {
        Number := "0x" SubStr("0000" SubStr(Number, 3), -3)
        String3 := Number "`n"
    }

    ; 若十六進制數字的字串長度小於 10 (含 0x)
    If (StrLen(Number) < 10)
    {
        Number := "0x" SubStr("00000000" SubStr(Number, 3), -7)
        String4 := Number
        String2 .= "`n"
    }

    ; 數字格式重設為十進制，避免影響本函式之後的程式碼
    SetFormat, Integer, D

    ; 合併字串
    Loop, 4
    {
        String .= String%A_Index%
    }

    Return, String
}

; --------------------------------------------------------------------
; 送出分隔線
; --------------------------------------------------------------------
CommentLine(Comment = "", Line = "-")
{
    global DefaultMargin
    Margin := DefaultMargin

    ; 若有註解符號
    If (Comment)
    {
        Text := Comment " "
        Length := Margin - StrLenW(Text)
        Loop, %Length%
        {
            Text .= Line
        }
    }
    Else
    {
        Loop, %Margin%
        {
            Text .= Line
        }
    }

    Return, Text "`n"
}

; --------------------------------------------------------------------
; 送出剪貼簿文字分隔線
; --------------------------------------------------------------------
CommentText(Comment = "", Line = "-")
{
    global DefaultMargin
    Margin := DefaultMargin

    ; 若剪貼簿沒有資料
    ClipText := Clipboard
    If (ClipText = "")
    {
        Return
    }

    ; 若有註解符號
    If (Comment)
    {
        Text1 := Comment " " Line Line Line Line
    }
    Else
    {
        Text1 := Line Line Line Line
    }
    Length1 := StrLen(Text1)

    ; 移除換行字元、Tab 字元、首尾多餘空白
    StringReplace, ClipText, ClipText, `r`n,, All
    StringReplace, ClipText, ClipText, % "`t", % " ", All
    ClipText := Trim(ClipText)
    Text2 := " " ClipText " "
    Length2 := StrLenW(Text2)

    ; 若文字超過邊界 (右邊預留 4 個分隔線字元)
    If (Length1 + Length2 > Margin - 4)
    {
        Return
    }

    ; 設定分隔線
    Length3 := Margin - Length1 - Length2
    Loop, %Length3%
    {
        Text3 .= Line
    }

    Return, Text1 Text2 Text3 "`n"
}

; --------------------------------------------------------------------
; 剪貼簿文字置中分隔線
; --------------------------------------------------------------------
TitleLine(Line = "-")
{
    global DefaultMargin
    Margin := DefaultMargin

    ; 若剪貼簿沒有資料
    ClipText := Clipboard
    If (ClipText = "")
    {
        Return
    }

    ; 移除換行字元、Tab 字元、首尾多餘空白
    StringReplace, ClipText, ClipText, `r`n,, All
    StringReplace, ClipText, ClipText, % "`t", % " ", All
    ClipText := Trim(ClipText)
    Text2 := " " ClipText " "
    Length2 := StrLenW(Text2)

    ; 若文字超過邊界 (左右共留 8 個分隔線字元)
    If (Length2 > Margin - 8)
    {
        Return
    }

    ; 設定分隔線
    Length1 := (Margin - Length2) // 2
    Loop, %Length1%
    {
        Text1 .= Line
    }
    Length3 := Margin - Length1 - Length2
    Loop, %Length3%
    {
        Text3 .= Line
    }

    Return, Text1 Text2 Text3 "`n"
}

; --------------------------------------------------------------------
; 剪貼簿文字置中
; --------------------------------------------------------------------
TitleText()
{
    global DefaultMargin
    Margin := DefaultMargin

    ; 若剪貼簿沒有資料
    ClipText := Clipboard
    If (ClipText = "")
    {
        Return
    }

    ; 移除換行字元、Tab 字元、首尾多餘空白
    StringReplace, ClipText, ClipText, `r`n,, All
    StringReplace, ClipText, ClipText, % "`t", % " ", All
    ClipText := Trim(ClipText)
    Text2 := ClipText
    Length2 := StrLenW(Text2)

    ; 若文字超過邊界
    If (Length2 > Margin)
    {
        Return
    }

    ; 將註解文字補上分隔線至邊界並換行
    Length1 := (Margin - Length2) // 2
    Loop, %Length1%
    {
        Text1 .= " "
    }

    Return, Text1 Text2 "`n"
}
