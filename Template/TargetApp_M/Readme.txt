========================================================================
		MIIIME Hybrid Launcher (MHL™)
========================================================================

MIIIMELauncher is not a one-click portable solution. It is a controlled execution environment.
Instead of hiding system behavior, it exposes it.
Instead of simplifying portability, it enforces consistency.
Not recommended unless you have a thorough understanding of file systems and registry structures.

미메런처는 원클릭 포터블 솔루션이 아닙니다. 제어된 실행 환경을 제공합니다.
시스템 동작을 숨기는 대신 노출합니다.
이식성을 단순화하는 대신 일관성을 강화합니다.
파일 시스템 및 레지스트리 구조에 대한 이해가 없는 경우 사용을 권장하지 않습니다.

========================================================================
[Mechanism]
========================================================================

1. Filesystem Virtualization
   - NTFS : Junction Point (Symbolic Link) redirection.
   - Non-NTFS : Automatic fallback to Physical Swap mode.
   
   [파일 시스템 가상화]
   - NTFS : Junction Point (심볼릭 링크) 리다이렉션 사용.
   - Non-NTFS : 물리적 Swap 모드로 자동 전환.

2. Registry Management
   - Injection : Seamless integration of HKCU keys.
   - Integrity : Hashing (MD5) applied to long key paths during backup.
   - Cleanup : Root key pruning and verified retrieval.

   [레지스트리 관리]
   - 주입 : HKCU 키의 무결절 통합.
   - 무결성 : 백업 시 긴 키 경로에 대한 해싱(MD5) 적용.
   - 정리 : 루트 키 가지치기 및 검증된 회수 수행.   
   
3. Forensic Recovery
   - Session Tracking : Monitors PID and Temp artifacts for crash detection.
   - Rollback : Restores previous state via `*.reg.bakk` snapshots on abnormal termination.

   [포렌식 복구]
   - 세션 추적 : 크래시 감지를 위해 PID 및 Temp 잔존 흔적 모니터링.
   - 롤백 : 비정상 종료 시 `*.reg.bakk` 스냅샷을 통한 이전 상태 복원.
   
4. Volatility Control (Freeze Mode)
   - Read-Only : Forces volatile state; no write-back to storage.
   - Auto-Redirection : Relocates execution context to Host Temp on RO media (CD/ISO/Write-Protected USB).

   [휘발성 제어 (동결 모드)]
   - 읽기 전용 : 휘발성 상태 강제. 스토리지 쓰기 방지.
   - 자동 우회 : RO 미디어(CD/ISO/USB) 감지 시 호스트 Temp로 실행 컨텍스트 자동 재배치.

5. Extensibility (Plugins)
   - Separation : Features (UserProfile, Injection) are isolated in `Ext` folder.
   - Independence : Each plugin has its own executable and configuration.
   
   [확장성 (플러그인)]
   - 분리 : 사용자 프로필, 시스템 주입 등은 `Ext` 폴더 내 독립 모듈로 분리.
   - 독립성 : 각 플러그인은 고유의 실행 파일과 설정을 가짐.

========================================================================
[Configuration]
========================================================================

1. Setup
   - Rename [TargetApp_M.exe] to match the target executable name.
   - Configure [TargetApp_M.ini] (Target path, AppName, etc.).
   - Place the target application folder inside [App].

   [설치]
   - [TargetApp_M.exe]를 타겟 실행 파일명으로 변경.
   - [TargetApp_M.ini] 설정 구성 (타겟 경로, 앱 이름 등).
   - [App] 폴더 내 타겟 애플리케이션 폴더 배치.

2. Directory Structure (상세 폴더 구조) 

  TargetApp_M/
 	│  
	├─ TargetApp_M.exe           	# Launcher Executable / 런처 실행 파일
 	├─ TargetApp_M.ini           	# Configuration File / 설정 파일
 	├─ TargetApp_M.log           	# Runtime Log / 실행 로그 (활성 시 생성)
 	│
 	├─ App/                   		# Core Files & Templates / 핵심 파일 및 템플릿
	│	├─ TargetApp/            	# Target Application / 원본 타겟 앱 바이너리
 	│	└─ RawDat/            		# Default Data Template / 데이터 초기 템플릿
	│ 		├─ AppDat/        	# System AppData Sandbox / 시스템 앱 데이터 샌드박스
	│		├─ Reg/             	# Registry Templates / 주입용 .reg 템플릿
	│		└─ Set/      			# Portable Settings / 앱 폴더 병합용 설정 파일      	
	│    	   
 	├─ Dat/                   			# Active User Data / 사용자 저장소 (수정 사항 저장)
 	│ 	   
 	└─ Ext/              			# Extensions / 확장 플러그인
 	  	├─ Adv_UserProfile/		# User Profile Virtualization
 	  	├─ Adv_SysInjection/		# System File Injection
 	  	├─ RegShell/			# Context Menu Integration
 	  	├─ FileWrite/			# Config File Patcher
 	  	├─ RegFix/				# Registry Patcher
 	  	└─ Resources/			# UI Resources
 	  	
 	  	Adv_ Extension files are for ADVANCED USERS ONLY.
		Adv_ 플러그인은 고급 사용자 전용입니다.

3. Customization
   - Core configuration via [TargetApp_M.ini].
   - Advanced features via Plugin INIs (e.g., Ext/UserProfile/UserProfile.ini).

   [사용자 정의]
   - [TargetApp_M.ini]를 통한 코어 설정.
   - 플러그인별 INI를 통한 고급 기능 설정 (예: 프로필 가상화 등).

______________________________________________________________________________________________________________________

This launcher was created with AutoIt. Some antivirus programs may incorrectly detect it as a virus.
본 런처는 AutoIt으로 제작되었습니다. 일부 백신이 바이러스로 오진 할 수 있습니다.

========================================================================
[Disclaimer]
========================================================================

Provided "AS IS" without warranty.
Private Project. No technical support provided.
본 프로그램은 “있는 그대로” 제공되며, 사용 중 발생하는 데이터 손실이나 시스템 문제에 대해 
제작자는 책임을 지지 않습니다.
기술 지원은 제공되지 않습니다.

Developer	: MIIIME 
Website		: https://www.miiime.com 
GitHub		: @miiime6248 
Update		: 2026.02.14
