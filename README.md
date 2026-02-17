# MIIIME Hybrid Launcher (MHL™)
MIIIMELauncher · 미메런처 · ミメランチャー<br>

![OS](https://img.shields.io/badge/Platform-Windows-0078D4?logo=windows&style=flat-square)
![Arch](https://img.shields.io/badge/Architecture-x86-blue?style=flat-square)
[![Language](https://img.shields.io/badge/Language-AutoIt-orange?logo=autoit&style=flat-square)](https://www.autoitscript.com/site/)
![License](https://img.shields.io/badge/License-Freeware-lightgrey?style=flat-square)
[![VirusTotal](https://img.shields.io/badge/VirusTotal-9%2F72_Detected-red?logo=virustotal&style=flat-square)](https://www.virustotal.com/gui/file/b162ae288550e4b13284b055e1bcf5b2dea2a6a9f8f3216da376195adc9ae9fe?nocache=1)

<br>
<img width="559" height="136" alt="001" src="https://github.com/user-attachments/assets/6d46085c-2b46-4d34-835b-de97f2b28f7c" style="margin-top: 20px; margin-bottom: 20px;">
<br><br>

> MIIIMELauncher is not a one-click portable solution. It is a controlled execution environment.  
> 미메런처는 원클릭 포터블 솔루션이 아닙니다. 제어된 실행 환경을 제공합니다.

Instead of hiding system behavior, it exposes it.  
Instead of simplifying portability, it enforces consistency.  
Not recommended unless you have a thorough understanding of file systems and registry structures.
  
시스템 동작을 숨기는 대신 노출합니다.   
이식성을 단순화하는 대신 일관성을 강화합니다.  
파일 시스템 및 레지스트리 구조에 대한 이해가 없는 경우 사용을 권장하지 않습니다.  

---

## Technical Stack

* **Core Engine** : AutoIt3, WinAPI (Kernel32, User32, Advapi32)
* **Process Management** : WMI (Windows Management Instrumentation) query-based monitoring.
* **FileSystem** : NTFS Junction Points (Reparse Points) & Physical Fallback.
* **Registry** : Native Hive Injection/Retrieval via Regedit binaries.

---

## Mechanism

### 1. Filesystem Virtualization
- **NTFS** : Junction Point (Symbolic Link) redirection.  
- **Non-NTFS** : Automatic fallback to Physical Swap mode.  
- **Robustness** : Smart retry logic for locked files during transition.

**[파일 시스템 가상화]**
- **NTFS** : Junction Point (심볼릭 링크) 리다이렉션 사용.  
- **Non-NTFS** : 물리적 Swap 모드로 자동 전환.
- **안전성** : 파일 잠김 발생 시 스마트 재시도 로직을 통해 데이터 무결성 보장.

### 2. Registry Management
- **Injection** : Seamless integration of HKCU keys.
- **Integrity** : Hashing (MD5) applied to long key paths during backup.
- **Cleanup** : Root key pruning and verified retrieval.

**[레지스트리 관리]**
- **주입** : HKCU 키의 무결절 통합.
- **무결성** : 백업 시 긴 키 경로에 대한 해싱(MD5) 적용.
- **정리** : 루트 키 가지치기 및 검증된 회수 수행.

### 3. Forensic Recovery
- **Session Tracking** : Validates session integrity via UUID and PID monitoring.
- **Rollback** : Transaction-based recovery using `*.reg.bakk` snapshots.

**[포렌식 복구]**
- **세션 추적** : UUID 및 PID 모니터링을 통한 세션 무결성 검증.
- **롤백** : 트랜잭션 기반의 스냅샷(`*.reg.bakk`)을 이용한 정밀 복구.

### 4. Volatility Control (Freeze Mode)
- **Read-Only** : Forces volatile state; no write-back to storage.  
- **Auto-Redirection** : Relocates execution context to Host Temp on RO media  
  (CD / ISO / Write-Protected USB).  

**[휘발성 제어 (동결 모드)]**
- **읽기 전용** : 휘발성 상태 강제, 스토리지 쓰기 방지.  
- **자동 우회** : RO 미디어(CD/ISO/USB) 감지 시 호스트 Temp로 실행 컨텍스트 자동 재배치.
  
### 5. Extensibility (Plugin Architecture)
- **Modular Plugins** : Features like UserProfile, Shell, and Injection are separated into independent modules.
- **Isolation** : Each plugin operates with its own configuration, minimizing core dependency.

**[확장성 (플러그인 아키텍처)]**
- **모듈형 플러그인** : 사용자 프로필, 쉘 통합, 시스템 주입 등의 기능을 독립 모듈로 분리.
- **격리성** : 각 플러그인은 고유 설정을 가지며 코어 의존성을 최소화.

---

## Configuration 

### 1. Quick Setup
- **Naming Convention** : The filenames `TargetApp_M.exe` and `TargetApp_M.ini` must match the name of the target executable file.  
  The suffix `_M` must be included at the end of the filename for management and identification purposes.
- **Binary Placement** : Place the target application folder inside the `App/` directory.

**[빠른 설정]**
- **네이밍 규칙** : `TargetApp_M.exe` 및 `TargetApp_M.ini` 파일명은 타겟 실행 파일과 일치해야 하며,  
  관리 및 식별을 위해 파일명 끝에 반드시 `_M` 접미사를 포함 해야 함.  
- **바이너리 배치** : 타겟 애플리케이션 폴더를 `App/` 디렉토리 내부에 배치.  

### 2. Directory Structure 
```text
TargetApp_M/
  │
  ├─ TargetApp_M.exe           # Launcher Executable
  ├─ TargetApp_M.ini           # Configuration File
  ├─ TargetApp_M.log           # Runtime Log
  │
  ├─ App/                      # Core Files & Templates 
  │   ├─ TargetApp/            # Target Application Binaries 
  │   └─ RawDat/               # Default Data Template 
  │       ├─ AppDat/           # Sandbox: Local, LocalLow, Roaming
  │       ├─ Reg/              # Registry: .reg templates 
  │       └─ Set/              # Settings: App folder merging 
  │
  ├─ Dat/                      # Active User Data (Persistent) 
  │
  └─ Ext/                      # Extensions (Plugins)
      ├─ Adv_UserProfile/      # %USERPROFILE% Virtualization
      ├─ Adv_SysInjection/     # System File Injection (Drivers/DLLs)
      ├─ RegShell/             # Context Menu Integration
      ├─ FileWrite/            # Config File Patcher
      ├─ RegFix/               # Registry Patcher
      └─ Resources/            # UI Resources (Icon, Splash)

      Adv_ Extension files are for ADVANCED USERS ONLY
```

**[디렉토리 구조]**

* **런처 실행 파일** : 런처 본체 및 동작 환경 정의를 위한 설정 파일.
* **App 영역** : 원본 앱 바이너리 및 사용자 데이터 초기 상태를 위한 템플릿.
* **Dat 영역** : 사용자가 수정한 사항이 저장되는 실제 데이터 저장소.
* **Ext 영역** : 기능 확장을 위한 플러그인(프로필 가상화, 시스템 주입, 쉘 통합 등) 폴더.  
                 (주의 : Adv_ 플러그인은 고급 사용자 전용입니다.)

### 3. Technical Specification (`ini`)

#### **[INI Parameters] (`TargetApp_M.ini`)**

Key configuration values for the launcher behavior.  
런처 동작을 제어하는 주요 설정 값. 

| Parameter | Section | Type | Description |
| --- | --- | --- | --- |
| `RunAsAdmin` | Launch | Bool | 1=Force Administrator privileges, 0=User mode |
| `UseJunction` | Options | Bool | **1=Symbolic Link (Recommended)**, 0=Physical Copy mode |
| `FreezeMode` | Options | Bool | 1=Non-persistent (Volatile / Read-Only), 0=Persistent |
| `LogLevel` | Options | Int | 0=Off, 1=All, 2=Debug, 3=Info, 4=Warn, 5=Error |
| `ProcessCheckInterval` | Advanced | Int | Polling interval (ms) for child process monitoring |

#### **[Environment] & Macros**

**Macro System** : Supports a macro system for path flexibility.  
**매크로 시스템** : 경로 유연성을 위해 매크로 시스템을 지원.

* **Paths** : `{Base}`, `{Run}`, `{Dat}`, `{Raw}`, `{Ext}`
* **System** : `{Windows}`, `{System32}`, `{SysNative}`, `{ProgramFiles}`, `{CommonFiles}`, `{UserProfile}`, `{Docs}`
* **AppData** : `{Local}`, `{LocalLow}`, `{Roaming}`

---

## CLI Arguments

Supported command-line arguments for debugging and maintenance.  
디버깅 및 유지보수를 위해 지원되는 명령줄 인수.

```bash
TargetApp_M.exe [Options]

```
| Argument | Description |
| --- | --- |
| `--clean` | **Force Cleanup**: Deletes the `Dat/` directory and resets the environment |
| `--debug` | **Debug Mode**: Forces `LogLevel=2` (DEBUG) regardless of INI settings |

---

## 🛡️ Security & Anti-virus Info

### [✅ VirusTotal Analysis Report](https://www.virustotal.com/gui/file/b162ae288550e4b13284b055e1bcf5b2dea2a6a9f8f3216da376195adc9ae9fe?nocache=1)
| Status | Details |
| :--- | :--- |
| **Major Vendors** | **Clean** (Passed by AhnLab V3, Kaspersky, Microsoft, Avast, ESET, etc.) |
| **Detection Rate** | **9 / 72** (Mostly Heuristic/Generic/Trojan-type flags) |
| **Integrity** | The source code is transparently available for verification in this repository |

> This launcher was created with AutoIt. Some antivirus programs may incorrectly detect it as a virus.  
> 본 런처는 AutoIt으로 제작되었습니다. 일부 백신이 바이러스로 오진 할 수 있습니다. 

**File Checksum (SHA-256) :** `b162ae288550e4b13284b055e1bcf5b2dea2a6a9f8f3216da376195adc9ae9fe`

---

## Disclaimer

Provided **“AS IS”**, without warranty.  
This is a **private project**. No technical support is provided.

본 프로그램은 **“있는 그대로”** 제공되며, 사용 중 발생하는 문제에 대해 제작자는 책임을 지지 않습니다.  
기술 지원은 제공되지 않습니다.

---

## Project Information

**Developer** : MIIIME  
**Website** : https://www.miiime.com  
**GitHub** : [@miiime6248](https://github.com/miiime6248)  
**Last Update** : 2026-02-14  

<br>
<img width="64" height="64" alt="002" src="https://github.com/user-attachments/assets/bbe6602c-b38f-4db5-b7cd-3e4cbc2e4f86">  
<br>
<br>
<br>



