; --------------------------------------------------------------------
; 主程式
; --------------------------------------------------------------------
_Main:

; ---- 程式設定 ------------------------------------------------------

    #LTrim
    #NoEnv
    #SingleInstance, Force
    CoordMode, Mouse, Screen
    CoordMode, ToolTip, Screen
    SetControlDelay, -1
    SetKeyDelay, -1
    SetTitleMatchMode, RegEx

; ---- 程式資訊 ------------------------------------------------------

    ProductName    := "Total Hotkey"
    ProductVersion := "Version 0.9.00.00"
    LegalCopyright := "Copyright © 2007-2017 by Chien Chao-wen"
    ContactAuthor  := "E-mail: chaowen.chien@gmail.com"

; ---- 執行參數 ------------------------------------------------------

    Gosub, _Parameter

; ---- 模組設定 ------------------------------------------------------

    Gosub, _Candidate
    Gosub, _GUI
    Gosub, _Sound
    Gosub, _Symbol

; ---- 結束返回 ------------------------------------------------------

    Return
