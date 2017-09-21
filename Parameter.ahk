; --------------------------------------------------------------------
; 執行參數
; --------------------------------------------------------------------
_Parameter:

; ---- 執行參數預設值 ------------------------------------------------

    DefaultDrive  := "" ; 光碟機控制所使用的磁碟代號
    DefaultMargin := 70 ; 快速字串邊界

; ---- 讀入執行參數 --------------------------------------------------

    Loop, %0%
    {
        Param := %A_Index%

        If (RegExMatch(Param, "i)^/Drive:([C-Z])$", ParamPattern) and not ParamDrive)
        {
            ParamDrive := True
            DriveLetter := ParamPattern1
            Continue
        }

        If (RegExMatch(Param, "i)^/Margin:(\d+)$", ParamPattern) and not ParamMargin)
        {
            If (ParamPattern1 between 30 and 132)
            {
                ParamMargin := True
                WrapColumn := ParamPattern1
                Continue
            }
        }

        ParamError := True
        Break
    }

; ---- 設定執行參數 --------------------------------------------------

    If (not ParamError)
    {
        If (ParamDrive)
        {
            DefaultDrive := DriveLetter ":"
        }

        If (ParamMargin)
        {
            DefaultMargin := WrapColumn
        }
    }

; ---- 結束返回 ------------------------------------------------------

    Return
