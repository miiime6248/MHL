# MIIIME Hybrid Launcher (MHL™)
MIIIMELauncher · 미메런처 · ミメランチャー<br>

![OS](https://img.shields.io/badge/Platform-Windows-0078D4?logo=windows&style=flat-square)
![Arch](https://img.shields.io/badge/Architecture-x86-blue?style=flat-square)
[![Language](https://img.shields.io/badge/Language-AutoIt-orange?logo=autoit&style=flat-square)](https://www.autoitscript.com/site/)

<br>
<img width="559" height="136" alt="001" src="https://github.com/user-attachments/assets/6d46085c-2b46-4d34-835b-de97f2b28f7c" style="margin-top: 20px; margin-bottom: 20px;">
<br><br>

MIIIME Hybrid Launcher (MHL™) is not a one-click portable solution.  
It is a controlled execution environment.

- Instead of hiding system behavior, it exposes it.
- Instead of simplifying portability, it enforces consistency.
- Not recommended unless you have a thorough understanding of file systems and registry structures.

미메런처는 원클릭 포터블 솔루션이 아닙니다.  
제어된 실행 환경을 제공합니다. 

- 시스템 동작을 은폐하지 않고 노출합니다.  
- 이식의 단순화 대신 환경의 일관성을 강화합니다.  
- 파일 시스템 및 레지스트리 구조에 대한 이해가 없는 경우 사용을 권장하지 않습니다.  

---

## Mechanism


### 1. Filesystem Virtualization
- **NTFS** : Junction Point (Symbolic Link) redirection.  
- **Non-NTFS** : Automatic fallback to Physical Swap mode.  

**[파일 시스템 가상화]**
- **NTFS** : Junction Point (심볼릭 링크) 리다이렉션 사용.  
- **Non-NTFS** : 물리적 Swap 모드로 자동 전환.


### 2. Forensic Recovery
- **Session Tracking** : Monitors PID and Temp artifacts for crash detection.  
- **Rollback** : Restores previous state via snapshots on abnormal termination.  

**[포렌식 복구]**
- **세션 추적** : 크래시 감지를 위해 PID 및 Temp 잔존 흔적 모니터링.  
- **롤백** : 비정상 종료 시 스냅샷을 통한 이전 상태 복원.


### 3. Registry Management
- **Injection** : Seamless integration of HKCU keys.  
- **Integrity** : Hashing (MD5) applied to long key paths during backup.  
- **Cleanup** : Root key pruning and verified retrieval.  

**[레지스트리 관리]**
- **주입** : HKCU 키의 무결절 통합.  
- **무결성** : 백업 시 긴 키 경로에 대한 해싱(MD5) 적용.  
- **정리** : 루트 키 가지치기 및 검증된 회수 수행.


### 4. Volatility Control (Freeze Mode)
- **Read-Only** : Forces volatile state; no write-back to storage.  
- **Auto-Redirection** : Relocates execution context to Host Temp on RO media  
  (CD / ISO / Write-Protected USB).  

**[휘발성 제어 (동결 모드)]**
- **읽기 전용** : 휘발성 상태 강제, 스토리지 쓰기 방지.  
- **자동 우회** : RO 미디어(CD/ISO/USB) 감지 시.  
  호스트 Temp로 실행 컨텍스트 자동 재배치.

---

## Configuration


### 1. Quick Setup
- **Naming Convention** : The filenames `TargetApp_M.exe` and `TargetApp_M.ini` must match the name of the target executable file.  
  The suffix `_M` must be included at the end of the filename for management and identification purposes.
- Binary Placement: Place the target application folder inside the App/ directory.
- NTFS Requirement: The host filesystem must be NTFS when using Junction mode (UseJunction=1).

**[빠른 설정]**
- **네이밍 규칙** : `TargetApp_M.exe` 및 `TargetApp_M.ini` 파일명은 타겟 실행 파일과 일치해야 하며,  
  관리 및 식별을 위해 파일명 끝에 반드시 `_M` 접미사를 포함 할 것.  
- **바이너리 배치** : 타겟 애플리케이션 폴더를 `App/` 디렉토리 내부에 배치.  
- **NTFS 요구 사항** : Junction 모드(`UseJunction=1`) 사용 시 호스트 파일 시스템은 반드시 NTFS여야 함.  


### 2. Directory Structure
```text
TargetApp_M/
  │
  ├─ TargetApp_M.exe           # Launcher Executable (AutoIt-based)
  ├─ TargetApp_M.ini           # Configuration File (Behavior & Env)
  ├─ TargetApp_M.log           # Runtime Log (If EnableLog=1)
  │
  ├─ App/                      # Core Files & Templates 
  │   ├─ TargetApp/            # Target Application Binaries 
  │   └─ RawDat/               # Default Data Template 
  │       ├─ AppDat/           # Sandbox : Local, LocalLow, Roaming
  │       ├─ Reg/              # Registry : .reg templates 
  │       ├─ Set/              # Settings : App folder merging 
  │       └─ Usr/              # User Profile : %USERPROFILE% injection
  │
  ├─ Dat/                      # Active User Data (Persistent) 
  │
  └─ Ext/                      # Extensions & Resources 
      ├─ Ast/                  # Assets : Runtime app directory copy
      ├─ Inj/                  # Injection : Host system file injection
      └─ Res/                  # UI Resources : Splash & Icons
```

**[디렉토리 구조]**
- **런처 실행 파일** : AutoIt 기반 런처 본체 및 동작 환경 정의를 위한 설정 파일.
- **App 영역** : 원본 앱 바이너리 및 사용자 데이터 초기 상태를 위한 템플릿(AppDat, Reg, Set, Usr).
- **Dat 영역** : 사용자가 수정한 사항이 저장되는 실제 데이터 저장소.
- **Ext 영역** : 런타임에 주입될 추가 어셋(Ast), 시스템 주입 파일(Inj), UI 리소스(Res) 배치.


### 3. Technical Specification (INI)

#### **[Environment] & Macros**
- **Macro System**: Supports a powerful macro system for path flexibility, applicable to all INI settings.  
- **Paths** : `{Base}`, `{Run}`, `{Dat}`, `{Raw}`, `{Ext}`, `{Inj}`, `{Ast}`, `{Res}`  
- **System** : `{Windows}`, `{System32}`, `{SysNative}`, `{ProgramFiles}`, `{CommonFiles}`, `{UserProfile}`, `{Docs}`  
- **AppData** : `{Local}`, `{LocalLow}`, `{Roaming}`  

**[환경 및 매크로]**
- **매크로 시스템** : 경로 유연성을 위해 강력한 매크로 시스템을 지원하며, 모든 INI 설정에서 사용 가능.  
- **경로 매크로** : 기본 경로(`{Base}`), 실행 경로(`{Run}`), 데이터 경로(`{Dat}`) 등을 포함.  
- **시스템 및 앱데이터** : 윈도우 주요 시스템 폴더 및 AppData(Local, Roaming 등) 경로를 자동으로 매핑.  

#### **[Registry] Systems**
- **Registry** : Defines HKCU keys to inject on launch and retrieve to `Dat/Reg` on exit.  
- **RegistryFix** : Dynamically modifies registry values (e.g., installation paths) immediately after launch.  
- **RegistryShell** : Integrates the app into the Windows Explorer context menu.  

**[레지스트리 시스템]**
- **레지스트리** : 실행 시 주입하고 종료 시 `Dat/Reg`로 회수할 HKCU 키를 정의.  
- **레지스트리 수정** : 실행 직후 특정 레지스트리 값을 타겟 환경에 맞춰 동적으로 수정.  
- **레지스트리 쉘** : 윈도우 탐색기 우클릭 메뉴에 앱을 등록하여 쉘 통합을 구현.  

#### **[Extension & Maintenance]**
- **ExtensionAssets** : Merges files/folders from `Ext/Ast` into the app path (`{Run}`) at runtime.  
- **ExtensionInjection** : Handles injection of host system files (drivers, DLLs) with backup and recovery support.  
- **CleanupPath** : Deletes unnecessary host caches or logs before the retrieval phase to prevent `Dat` pollution.  
- **FileWrite** : Dynamically replaces specific strings or key values within configuration files at runtime.  

**[확장 및 유지관리]**
- **확장 어셋** : `Ext/Ast` 내부의 파일이나 폴더를 실행 시점에 앱 경로로 병합.  
- **확장 주입** : 시스템 파일(드라이버, DLL 등) 주입을 처리하며, 원본 백업 및 복구를 지원.  
- **경로 정리** : 데이터 회수 직전 불필요한 캐시나 로그를 삭제하여 `Dat` 폴더 오염을 방지.  
- **파일 쓰기** : 실행 시점에 설정 파일 내부의 특정 문자열이나 키 값을 동적으로 치환.  

---

## 🛡️ Security & Anti-virus Info

[![VirusTotal](https://img.shields.io/badge/VirusTotal-11%2F72_Detected-red?logo=virustotal&style=flat-square)](https://www.virustotal.com/gui/file/d12999d1d5009052b69843b823dde7048ccaebca87c70e85af1527865e3e58ca?nocache=1)

### [✅ VirusTotal Analysis Report](https://www.google.com/search?q=https://www.virustotal.com/gui/file/d12999d1d5009052b69843b823dde7048ccaebca87c70e85af1527865e3e58ca?nocache=1)

| Status | Details |
| --- | --- |
| **Major Vendors** | **Clean** (Passed by AhnLab-V3, Kaspersky, BitDefender, Microsoft, ESET, etc.) |
| **Detection Rate** | **11 / 72** (Mostly Heuristic/Trojan-type flags by minor vendors) |
| **Integrity** | The source code is transparently available for verification in this repository. |

> **Note:** If your antivirus blocks the program, please add it to the exclusion list or refer to the VirusTotal report above.  

오토잇으로 제작되었습니다. 일부 보안 엔진에서 오진(False Positive)될 수 있습니다. 

**File Checksum (SHA-256):** `d12999d1d5009052b69843b823dde7048ccaebca87c70e85af1527865e3e58ca`

---

<br>
<img width="64" height="64" alt="002" src="https://github.com/user-attachments/assets/bbe6602c-b38f-4db5-b7cd-3e4cbc2e4f86" style="margin-top: 20px; margin-bottom: 20px;">

## Disclaimer

Provided **“AS IS”**, without warranty.  
This is a **private project**. No technical support is provided.

본 프로그램은 **“있는 그대로”** 제공되며, 사용 중 발생하는 문제에 대해 제작자는 책임을 지지 않습니다.  
기술 지원은 제공되지 않습니다.

---

## Project Information

- **Developer** : MIIIME  
- **Website** : https://www.miiime.com
- **GitHub** : [@miiime6248](https://github.com/miiime6248)  
- **Last Update** : 2026-02-07
