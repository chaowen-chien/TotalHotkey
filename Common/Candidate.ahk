; --------------------------------------------------------------------
; 設定選字編號
; --------------------------------------------------------------------
_Candidate:
    CandidateNumber := "1234567890QWERTYUIOPASDFGH"
    StringSplit, CandidateNumber, CandidateNumber
    Return

; --------------------------------------------------------------------
; 取得選字索引
; --------------------------------------------------------------------
CandidateSelect:
    CandidateIndex := A_ThisMenuItemPos
    Return

; --------------------------------------------------------------------
; 顯示選字視窗
; --------------------------------------------------------------------
CandidateWindow()
{
    global CandidateIndex := 0, CandidateList, CandidateNumber0
    StringSplit, CandidateList, CandidateList, `n

    ; 若選字列表不存在
    If (not CandidateList0)
    {
        Return
    }

    ; 清除選字選單
    Menu, CandidateWindow, Add
    Menu, CandidateWindow, DeleteAll

    ; 設定選字選單
    Count := CandidateList0 < CandidateNumber0 ? CandidateList0 : CandidateNumber0
    Loop, %Count%
    {
        ItemText := CandidateNumber%A_Index% ":`t" CandidateList%A_Index%
        Menu, CandidateWindow, Add, %ItemText%, CandidateSelect
    }

    ; 顯示選字選單
    ControlGetFocus, Control
    ControlGetPos, CX, CY,,, %Control%
    X := A_CaretX < 0 ? CX : A_CaretX
    Y := A_CaretY < 0 ? CY : A_CaretY + 20
    Menu, CandidateWindow, Show, %X%, %Y%

    ; 若取消選字
    If (not CandidateIndex)
    {
        Return
    }

    ; 送出選字
    SendString(CandidateList%CandidateIndex%)
}
