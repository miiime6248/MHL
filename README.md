# MIIIME Hybrid Launcher (MHL™)
MIIIME Launcher · 미메런처 · ミメランチャー<br>

[![VirusTotal Guide](https://img.shields.io/badge/VirusTotal-19%2F72_Detected-red?logo=virustotal)](https://www.virustotal.com/gui/file/4f08d078fc78b8853185c2477b624648921276cdc0cef866fc8feb53a0960097?nocache=1)
[![Latest Release](https://img.shields.io/github/v/release/miiime6248/MHL?color=blue)](https://github.com/miiime6248/MHL/releases/latest)

<br>
<img width="559" height="136" alt="001" src="https://github.com/user-attachments/assets/6d46085c-2b46-4d34-835b-de97f2b28f7c" style="margin-top: 20px; margin-bottom: 20px;">
<br><br>

> Not a one-click solution.  
> A controlled execution environment designed for consistency, not convenience.

MIIIME Hybrid Launcher (MHL™) is not a one-click portable launcher.  
It is a controlled execution environment.

- Instead of hiding system behavior, it **exposes it**
- Instead of simplifying portability, it enforces consistency
- Designed for **environment fidelity**, not user convenience

미메 런처는 원클릭 솔루션이 아닙니다.  
제어된 실행 환경을 제공합니다.

- 시스템 동작을 은폐하지 않고 의도적으로 노출 합니다.
- 이식성을 단순화하는 대신 환경 일관성을 강제합니다
- 파일 시스템 및 레지스트리 구조에 대한 이해가 없는 경우 사용을 권장하지 않습니다


---

## Mechanism

### 1. Filesystem Virtualization
- **NTFS**: Junction Point (Symbolic Link) redirection  
- **Non-NTFS**: Automatic fallback to Physical Swap mode  

**[파일 시스템 가상화]**
- **NTFS**: Junction Point (심볼릭 링크) 리다이렉션 사용  
- **Non-NTFS**: 물리적 Swap 모드로 자동 전환


### 2. Forensic Recovery
- **Session Tracking**: Monitors PID and Temp artifacts for crash detection  
- **Rollback**: Restores previous state via `*.reg.bakk` snapshots on abnormal termination  

**[포렌식 복구]**
- **세션 추적**: 크래시 감지를 위해 PID 및 Temp 잔존 흔적 모니터링  
- **롤백**: 비정상 종료 시 `*.reg.bakk` 스냅샷을 통한 이전 상태 복원


### 3. Registry Management
- **Injection**: Seamless integration of HKCU keys  
- **Integrity**: Hashing (MD5) applied to long key paths during backup  
- **Cleanup**: Root key pruning and verified retrieval  

**[레지스트리 관리]**
- **주입**: HKCU 키의 무결절 통합  
- **무결성**: 백업 시 긴 키 경로에 대한 해싱(MD5) 적용  
- **정리**: 루트 키 가지치기 및 검증된 회수 수행


### 4. Volatility Control (Freeze Mode)
- **Read-Only**: Forces volatile state; no write-back to storage  
- **Auto-Redirection**: Relocates execution context to Host Temp on RO media  
  (CD / ISO / Write-Protected USB)  

**[휘발성 제어 (동결 모드)]**
- **읽기 전용**: 휘발성 상태 강제, 스토리지 쓰기 방지  
- **자동 우회**: RO 미디어(CD/ISO/USB) 감지 시  
  호스트 Temp로 실행 컨텍스트 자동 재배치


---

## Configuration

### 1. Setup
- Rename `noname_M.exe` to match the target executable name  
- Configure `noname_M.ini` (target path, AppName, etc.)  
- Place the target application folder inside `App/`  

**[설치]**
- `noname_M.exe`를 타겟 실행 파일명으로 변경  
- `noname_M.ini` 설정 구성 (타겟 경로, 앱 이름 등)  
- `App/` 폴더 내 타겟 애플리케이션 폴더 배치


### 2. Directory Structure
```text
noname_M/
 ├─ noname_M.exe            # Launcher / 런처
 ├─ noname_M.ini            # Configuration / 설정
 ├─ Dat/                    # User Data (Auto-generated) / 사용자 데이터 (자동 생성)
 └─ App/
     ├─ noname/             # Target Application / 타겟 앱
     ├─ RawDat/             # Default Data Template / 데이터 템플릿
     │   ├─ AppDat/
     │   │   ├─ Local/
     │   │   ├─ LocalLow/
     │   │   └─ Roaming/
     │   ├─ Reg/
     │   └─ Set/
     └─ Usr/                # User Files / 사용자 파일
         ├─ Ast/
         ├─ Ext/
         └─ Res/ 
```

### 3. Customization
- Configuration is strictly defined via **INI**
- Supports **Environment Variables**, **Shell Integration**, and **Asset Injection**

**[사용자 정의]**
- INI 기반 설정 정의  
- 환경 변수, 쉘 통합, 외부 에셋 주입 지원

---

## 🛡️ Security & Anti-virus Info

This project is built using **AutoIt**. Some antivirus engines may flag it as a "False Positive" due to the nature of scripted executables.

### [✅ VirusTotal Analysis Report](https://www.virustotal.com/gui/file/4f08d078fc78b8853185c2477b624648921276cdc0cef866fc8feb53a0960097?nocache=1)

| Status | Details |
| :--- | :--- |
| **Major Vendors** | **Clean** (Passed by Microsoft Defender, Kaspersky, AhnLab V3, Avast, etc.) |
| **Detection Rate** | 19 / 72 (Mostly Heuristic/Generic flags) |
| **Integrity** | You can verify the source code in this repository. |

> **Note:** If your antivirus blocks the program, please add it to the exclusion list or refer to the VirusTotal report above.

**File Checksum (SHA-256):** `4f08d078fc78b8853185c2477b624648921276cdc0cef866fc8feb53a0960097`

---

<br>
<img width="64" height="64" alt="002" src="https://github.com/user-attachments/assets/bbe6602c-b38f-4db5-b7cd-3e4cbc2e4f86" style="margin-top: 20px; margin-bottom: 20px;">

## Disclaimer

Provided **“AS IS”**, without warranty.  
This is a **private project**. No technical support is provided.

본 프로그램은 **“있는 그대로”** 제공되며,  
사용 중 발생하는 데이터 손실이나 시스템 문제에 대해 제작자는 책임을 지지 않습니다.  
기술 지원은 제공되지 않습니다.

---

## Project Information

- **Developer**: MIIIME  
- **Website**: https://www.miiime.com  https://www.c6248.com  
- **GitHub**: [@miiime6248](https://github.com/miiime6248)  
- **Last Update**: 2026-01-31
