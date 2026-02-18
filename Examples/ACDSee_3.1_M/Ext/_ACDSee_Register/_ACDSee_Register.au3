#cs
    MIIIME Hybrid Launcher - ACDSee 3.1 Register Plugin (Smart Cache)
    ⓒ 2026 MIIIME
    
    [Logic Update]
    1. Smart Cache: 경로 변경 시에만 InfoCache 초기화 (부팅 속도 최적화)
    2. Dual Architecture: 64비트 OS에서 32비트 레지스트리(WOW64) 자동 처리
#ce

#NoTrayIcon
#RequireAdmin 
#include "..\Plugin_Common.au3"

Opt('MustDeclareVars', 1)

; 1. 플러그인 초기화
_Plugin_Init("PLUGIN:_ACDSee_Register")

Switch $g_sPluginEvent
    Case "PreLaunch"
        _ACDSee_Register()
    Case "PostExit", "Exit"
        _ACDSee_Unregister()
EndSwitch
Exit

; =================================================================================================
; 함수:      _ACDSee_Register
; 설명:      스마트 캐시 로직이 적용된 등록 함수
; =================================================================================================
Func _ACDSee_Register()
    _Plugin_Utils_Log("Processing Registration...")

    ; 1. 경로 및 키 정의
    Local $sDirPlugins = $g_DirRun & "\PlugIns"
    Local $sBaseKey    = "HKLM\SOFTWARE\WOW6432Node\ACD Systems\PlugIns"
    
    ; 64비트 OS가 아닌 경우(32비트 OS) 경로 보정
    If @OSArch <> "X64" Then $sBaseKey = "HKLM\SOFTWARE\ACD Systems\PlugIns"
    
    Local $sInfoCache  = $sBaseKey & "\InfoCache"
    Local $sStateIni   = $g_DirDat & "\Set\PluginInfo.ini"
    
    ; 2. 경로 비교 준비
    Local $sOldPath = IniRead($sStateIni, "State", "LastPluginPath", "")
    Local $sNewPath = $sDirPlugins & "\"
    
    ; 경로 끝 백슬래시(\) 보정 (문자열 정확한 비교를 위해)
    If StringRight($sOldPath, 1) <> "\" And $sOldPath <> "" Then $sOldPath &= "\"
    If StringRight($sNewPath, 1) <> "\" Then $sNewPath &= "\"

    ; -------------------------------------------------------------------------
    ; [핵심 로직] 경로 변경 감지 및 스마트 캐시 처리
    ; -------------------------------------------------------------------------
    Local $bNeedUpdate = False
    
    ; A. 경로가 실제로 변경되었는가?
    If $sOldPath <> $sNewPath Then
        _Plugin_Utils_Log("Plugin Path Changed: [" & $sOldPath & "] -> [" & $sNewPath & "]", "INFO")
        $bNeedUpdate = True
    Else
        ; B. 경로는 같지만 레지스트리 키가 소실되었는가? (방어 로직)
        ; 32비트 레지스트리 값을 읽어서 확인
        Local $sCurrentRegVal = RegRead($sBaseKey, "PIFolder")
        If $sCurrentRegVal <> $sNewPath Then
             _Plugin_Utils_Log("Registry Key Missing or Mismatched. Repairing...", "WARN")
             ; 주의: 키만 복구하고 캐시는 유지할 수도 있지만, 안전을 위해 업데이트 로직을 태움
             $bNeedUpdate = True 
        Else
             _Plugin_Utils_Log("Path Matches & Registry Exists. Skipping Cache Clear.", "INFO")
        EndIf
    EndIf

    If $bNeedUpdate Then
        ; (A) InfoCache 하위 키 삭제 (초기화)
        ; 경로가 바뀌었을 때만 수행하여 로딩 속도 저하 방지
        Local $sSubKey, $i = 1
        While 1
            $sSubKey = RegEnumKey($sInfoCache, $i)
            If @error Then ExitLoop
            RegDelete($sInfoCache & "\" & $sSubKey)
            ; 삭제하면 인덱스가 당겨지므로 $i를 증가시키지 않거나 1로 초기화
            $i = 1 
        WEnd
        _Plugin_Utils_Log("InfoCache Cleared.", "INFO")
        
        ; (B) 새로운 경로 등록 (Dual Architecture)
        ; HKLM\SOFTWARE\ACD Systems\PlugIns 및 WOW6432Node 양쪽에 기록
        Local $sNativeKey = "HKEY_LOCAL_MACHINE\SOFTWARE\ACD Systems\PlugIns"
        _ACDSee_RegWrite_Dual($sNativeKey, "PIFolder", "REG_SZ", $sNewPath)
        
        ; (C) 상태 파일 업데이트
        If Not FileExists($g_DirDat & "\Set") Then DirCreate($g_DirDat & "\Set")
        IniWrite($sStateIni, "State", "LastPluginPath", $sNewPath)
    EndIf
    
    ; -------------------------------------------------------------------------
    ; [Help File] 도움말 경로는 캐시와 무관하므로 항상 보장 (Dual Write)
    ; -------------------------------------------------------------------------
    Local $sHelpNative = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Help"
    _ACDSee_RegWrite_Dual($sHelpNative, 'ACDSee.hlp', 'REG_SZ', $g_DirRun & "\")
    _ACDSee_RegWrite_Dual($sHelpNative, 'ACDSeeOverview.hlp', 'REG_SZ', $g_DirRun & "\")
EndFunc

; =================================================================================================
; 함수:      _ACDSee_Unregister
; 설명:      종료 시 정리
; =================================================================================================
Func _ACDSee_Unregister()
    ; Help 파일 정리 (Dual Delete)
    Local $sHelpNative = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Help"
    _ACDSee_RegDelete_Dual($sHelpNative, 'ACDSee.hlp')
    _ACDSee_RegDelete_Dual($sHelpNative, 'ACDSeeOverview.hlp')
EndFunc

; =================================================================================================
; 헬퍼 함수: 이중 아키텍처 지원 (Dual Write/Delete)
; 설명: 64비트 OS에서 HKLM에 쓸 때 WOW6432Node에도 자동으로 처리
; =================================================================================================

Func _ACDSee_RegWrite_Dual($sKey, $sVal, $sType, $sData)
    ; 1. Native 쓰기
    RegWrite($sKey, $sVal, $sType, $sData)
    
    ; 2. WOW6432Node 쓰기 (64비트 OS인 경우)
    If @OSArch = "X64" And StringLeft($sKey, 19) = "HKEY_LOCAL_MACHINE\" And Not StringInStr($sKey, "WOW6432Node") Then
        Local $sKey32 = StringReplace($sKey, "SOFTWARE", "SOFTWARE\WOW6432Node", 1)
        RegWrite($sKey32, $sVal, $sType, $sData)
    EndIf
EndFunc

Func _ACDSee_RegDelete_Dual($sKey, $sVal)
    ; 1. Native 삭제
    RegDelete($sKey, $sVal)
    
    ; 2. WOW6432Node 삭제 (64비트 OS인 경우)
    If @OSArch = "X64" And StringLeft($sKey, 19) = "HKEY_LOCAL_MACHINE\" And Not StringInStr($sKey, "WOW6432Node") Then
        Local $sKey32 = StringReplace($sKey, "SOFTWARE", "SOFTWARE\WOW6432Node", 1)
        RegDelete($sKey32, $sVal)
    EndIf
EndFunc