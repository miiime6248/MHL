### Miime Hybrid Launcher
MIIIME Launcher · 미메런처 · ミメランチャー<br>
MHL™

<br>
<img width="559" height="136" alt="001" src="https://github.com/user-attachments/assets/6d46085c-2b46-4d34-835b-de97f2b28f7c" style="margin-top: 20px; margin-bottom: 20px;">
<br><br>

Miime Hybrid Launcher is a utility designed to run installed applications in a portable (non-install) environment. It virtualizes registries and personal settings during execution, ensuring that all data is securely recovered and no traces are left on the host system upon exit.

미메 런처는 설치형 프로그램을 포터블(무설치) 환경에서 구동할 수 있도록 돕는 도구입니다. 실행 시 레지스트리와 개인 설정을 가상화하여 관리하며, 종료 시 시스템에 흔적을 남기지 않고 데이터를 안전하게 회수합니다.

---

### Folder Structure

```text
noname_M
 │
 ├─ noname_M.exe    [Run] Launcher / 런처 실행 파일
 ├─ noname_M.ini    [Config] Settings / 설정 파일
 ├─ App             [App] Program Folder / 프로그램 폴더
 │   ├─ noname      Target Application / 구동할 프로그램
 │   └─ RawDat      Original Data / 사용자 데이터 원본
 ├─ Dat             [Data] User Data (Auto-generated) / 사용자 데이터 (자동 생성)
 ├─ Ext             [Extension] Assets, Icons, Splash / 확장 자산, 아이콘, 스플래시
 └─ Src             [Source] Source Code & Guides / 소스 코드 및 가이드

```

---

### How to Use

1.<br>
Place the program folder inside the **[App]** folder.  
**[App]** 폴더 내에 실행하고자 하는 프로그램 폴더를 넣습니다.

2.<br>
Open **[noname_M.ini]** and modify the AppName and paths.  
**[noname_M.ini]** 파일을 열어 앱 이름과 경로 등을 수정합니다.

3.<br>
Run **[noname_M.exe]** to start in portable mode.  
**[noname_M.exe]** 를 실행하면 포터블 모드로 작동합니다. 

---

* All user data is stored in the **[Dat]** folder. Keep this folder safe when moving via USB.  
모든 사용자 데이터는 **[Dat]** 폴더에 저장됩니다. USB 이동 시 이 폴더를 잘 보관하세요.


* Files in **[Ext/Ast]** are auto-copied to the program folder (e.g., skins, plugins).  
**[Ext/Ast]** 폴더에 파일을 넣으면 첫 실행 시 프로그램 폴더로 자동 복사됩니다 (예: 스킨, 플러그인 등).

* This launcher was created with AutoIt, so some antivirus programs may incorrectly detect it as a virus.  
본 런처는 AutoIt으로 제작되어 일부 백신이 바이러스로 잘못 탐지할 수 있습니다. 

---

<br>
<img width="64" height="64" alt="002" src="https://github.com/user-attachments/assets/bbe6602c-b38f-4db5-b7cd-3e4cbc2e4f86" style="margin-top: 20px; margin-bottom: 20px;">

### Contact

* This is a private project. The developer is not responsible for any issues arising from its use.  
본 프로그램은 개인 프로젝트이며, 사용 중 발생하는 문제에 대해 제작자는 책임을 지지 않습니다.

* **Developer**: Miime 

* **Website**: [https://www.miiime.com](https://www.miiime.com) (GitHub: [@miiime6248]) 

* **Update**: 2026.01.31




