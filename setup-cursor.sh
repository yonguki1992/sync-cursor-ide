#!/bin/bash

set -e

CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
BACKUP_DIR="$HOME/sync-cursor-ide/cursor"
EXTENSIONS_FILE="$BACKUP_DIR/extensions.txt"
LOG_DIR="$HOME/sync-cursor-ide/logs"
FAILED_LOG="$LOG_DIR/failed-extensions-$(date +%Y%m%d-%H%M%S).log"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "📂 복구 대상 디렉토리: ${YELLOW}$CURSOR_USER_DIR${NC}"

# logs 디렉토리 없으면 생성
mkdir -p "$LOG_DIR"

while true; do
  read -r -p "설정을 복구하시겠습니까? (Y/N): " yOrN
  case "$yOrN" in
    [Yy]* )
      if [ ! -d "$BACKUP_DIR" ]; then
        echo -e "${RED}❌ 백업 디렉토리($BACKUP_DIR)가 존재하지 않습니다.${NC}"
        exit 1
      fi

      echo -e "▶️  설정 파일 복원 중..."
      rsync -avh "$BACKUP_DIR"/ "$CURSOR_USER_DIR"/
      echo -e "${GREEN}✅ 설정 복원 완료${NC}"

      if [ -f "$EXTENSIONS_FILE" ]; then
        echo -e "🔌 플러그인 복원 중..."
        while IFS= read -r ext; do
          echo -e "📦 확장 설치 중: ${YELLOW}$ext${NC}"
          if ! cursor --install-extension "$ext" --force; then
            echo -e "${RED}❌ 설치 실패: $ext${NC}"
            echo "$ext" >> "$FAILED_LOG"
          fi
        done < "$EXTENSIONS_FILE"
        echo -e "${GREEN}✅ 플러그인 설치 완료${NC}"

        if [ -s "$FAILED_LOG" ]; then
          echo -e "${YELLOW}⚠️ 일부 확장이 실패했습니다. 로그 확인: $FAILED_LOG${NC}"
        fi
      else
        echo -e "${YELLOW}⚠️ 플러그인 목록 파일이 존재하지 않아 설치를 건너뜁니다.${NC}"
      fi
      break;;
    [Nn]* )
      echo "설정 복구를 취소하였습니다."
      break;;
    * ) echo "Y(y) 또는 N(n)으로 입력해주세요.";;
  esac
done
