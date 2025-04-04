#!/bin/bash

# sync-cursor.sh
# Cursor IDE 설정과 확장 목록을 백업합니다.

set -e

# 경로 설정
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
BACKUP_DIR="$HOME/sync-cursor-ide/cursor"
EXTENSIONS_FILE="$BACKUP_DIR/extensions.txt"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "📁 백업 디렉토리: ${YELLOW}$BACKUP_DIR${NC}"

mkdir -p "$BACKUP_DIR"

echo -e "📥 설정 파일 백업 중..."

rsync -av \
  --exclude='workspaceStorage/' \
  --exclude='globalStorage/' \
  --exclude='History/' \
  --exclude='*.log' \
  "$CURSOR_USER_DIR"/ "$BACKUP_DIR"/

echo -e "${GREEN}✅ 설정 백업 완료${NC}"

echo -e "🔌 설치된 확장 목록 저장 중..."
cursor --list-extensions > "$EXTENSIONS_FILE"
echo -e "${GREEN}✅ 확장 목록 저장 완료${NC}"
