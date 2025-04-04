# 🛠 Cursor IDE 설정 관리 (by 브랜치)

이 저장소는 **Cursor IDE의 설정과 확장(Extensions)** 을 백업 및 복원하는 용도로 사용됩니다. 각 브랜치는 프레임워크별 개발 환경에 맞춘 설정을 제공합니다.

## 📂 브랜치 구조

| 브랜치 이름    | 설명                        |
| --------- | ------------------------- |
| `main`    | 공통 설정 (프레임워크에 종속되지 않음)    |
| `vue`     | Vue 2.x / 3.x 기반 프로젝트용 설정 |

## 🔁 사용 방법

### 1. Clone Repository

```bash
cd ~
git clone https://github.com/yonguki1992/sync-cursor-ide.git
cd ~/sync-cursor-ide
```

### 2. 백업하기

```bash
./sync-cursor.sh
```

> 현재 Cursor 설정을 `./cursor/` 폴더에 백업합니다.

### 3. 복원하기

```bash
./setup-cursor.sh
```

> 저장소 내 설정을 `Cursor IDE` 사용자 디렉토리에 복원합니다.

## 📦 포함된 항목

- `settings.json`: 에디터 환경설정
- `keybindings.json`: 단축키 설정
- `extensions.txt`: 설치된 확장 목록
- `snippets/`: 사용자 정의 코드 스니펫 모음

## 💡 브랜치 전환 후 해야 할 일

```bash
# 커서 IDE를 완전히 종료 후 재시작하거나, 강제 reload
CMD + SHIFT + P → Reload Window
```

## ✅ 추천 사용법

- `main` 브랜치를 기반으로 `vue`, `react`, `svelte` 등의 브랜치를 파생
- 브랜치마다 필요한 확장 및 설정만 유지 → 경량화 + 빠른 로딩
