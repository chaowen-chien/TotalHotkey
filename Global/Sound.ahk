; --------------------------------------------------------------------
; 音量控制
;
; Win + NumpadAdd         主音量 +5%
; Win + NumpadSub         主音量 -5%
; Win + NumpadMult        主音量 [設為靜音／取消靜音]
; --------------------------------------------------------------------
#NumpadAdd:: SetVolume("MASTER", "+5")
#NumpadSub:: SetVolume("MASTER", "-5")
#NumpadMult::MuteVolume("MASTER")

; --------------------------------------------------------------------
; 設定提示音效
; --------------------------------------------------------------------
_Sound:
    ; hModule = 0 (Current Process)
    ; lpName = 1
    ; lpType = RT_RCDATA = 10
    hBeepResource := DllCall("FindResource", UInt, 0, UInt, 1, UInt, 10)
    ; hModule = 0 (Current Process)
    hBeepData := DllCall("LoadResource", UInt, 0, UInt, hBeepResource)
    pBeepData := DllCall("LockResource", UInt, hBeepData)
    Return

; --------------------------------------------------------------------
; 設為靜音／取消靜音
; --------------------------------------------------------------------
MuteVolume(Sound)
{
    SoundSet, +1, %Sound%, MUTE
    Gosub, Sound_OSD
}

; --------------------------------------------------------------------
; 設定單一音量
; --------------------------------------------------------------------
SetVolume(Sound, Volume)
{
    SoundSet, %Volume%, %Sound%
    Gosub, Sound_OSD
}

; --------------------------------------------------------------------
; 提示音效
; --------------------------------------------------------------------
Beep()
{
    global pBeepData
    SoundGet, Volume
    ; 若無法取得音效裝置的音量 (例如：未安裝音效卡)
    If (ErrorLevel)
    {
        SoundBeep
        Return
    }
    ; SND_MEMORY | SND_NODEFAULT = 4 | 2 = 6
    DllCall("winmm\sndPlaySoundA", UInt, pBeepData, UInt, 6)
}
