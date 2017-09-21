; --------------------------------------------------------------------
; 日期時間快速字串
; --------------------------------------------------------------------
:://date::
    SendString(A_YYYY "-" A_MM "-" A_DD)
    Return

:://time::
    SendString(A_Hour ":" A_Min ":" A_Sec)
    Return

:://wday::
    SendString(WeekDay())
    Return

WeekDay()
{
    FormatTime, String, L0x0404, yyyy-MM-dd dddd
    Return, String
}

; --------------------------------------------------------------------
; 日期時間分隔線
; --------------------------------------------------------------------
:://wl::
    SendString(WeekLine())
    Return

WeekLine(Line = "-")
{
    global DefaultMargin
    Margin := DefaultMargin

    Text1 := Line Line Line Line " " WeekDay() " "
    ; Text1 字串長度 = 23 (雙位元字以 2 計算)
    Length := Margin - 23
    Loop, %Length%
    {
        Text2 .= Line
    }
    Return, Text1 Text2 "`n"
}
