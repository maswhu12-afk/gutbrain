#!/bin/bash
# GutBrain — Полная установка с нуля
# Одна команда — и всё готово
#
# Использование:
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/maswhu12-afk/gutbrain/main/scripts/bootstrap.sh)"

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
CHECK="${GREEN}✓${NC}"
ARROW="${BLUE}→${NC}"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║      GutBrain — Полная установка         ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# ─── 1. Xcode Command Line Tools ───
echo -e "${ARROW} Xcode Command Line Tools..."
if xcode-select -p &>/dev/null; then
    echo -e "  ${CHECK} Уже установлен"
else
    echo -e "  ${YELLOW}Устанавливаю (появится окно — нажми Install)...${NC}"
    xcode-select --install 2>/dev/null || true
    echo -e "  ${YELLOW}Дождись установки и запусти скрипт ещё раз.${NC}"
    exit 1
fi

# ─── 2. Homebrew ───
echo -e "${ARROW} Homebrew..."
if command -v brew &>/dev/null; then
    echo -e "  ${CHECK} Уже установлен"
else
    echo -e "  ${YELLOW}Устанавливаю Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    fi
    echo -e "  ${CHECK} Homebrew установлен"
fi

# ─── 3. Node.js ───
echo -e "${ARROW} Node.js..."
if command -v node &>/dev/null; then
    echo -e "  ${CHECK} Node.js $(node --version)"
else
    brew install node
    echo -e "  ${CHECK} Node.js $(node --version) установлен"
fi

# ─── 4. Git ───
echo -e "${ARROW} Git..."
if command -v git &>/dev/null; then
    echo -e "  ${CHECK} Git $(git --version | awk '{print $3}')"
else
    brew install git
    echo -e "  ${CHECK} Git установлен"
fi

# ─── 5. Claude Code ───
echo -e "${ARROW} Claude Code..."
if command -v claude &>/dev/null; then
    echo -e "  ${CHECK} Claude Code уже установлен"
else
    npm install -g @anthropic-ai/claude-code
    echo -e "  ${CHECK} Claude Code установлен"
fi

# ─── 6. Клонируем проект ───
echo -e "${ARROW} Проект GutBrain..."
mkdir -p ~/Projects
if [ -d ~/Projects/gutbrain ]; then
    echo -e "  ${CHECK} Проект уже скачан"
    cd ~/Projects/gutbrain
    git pull --quiet origin main 2>/dev/null || true
else
    cd ~/Projects
    git clone https://github.com/maswhu12-afk/gutbrain.git
    cd gutbrain
    echo -e "  ${CHECK} Проект скачан"
fi

# ─── Готово ───
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║           ✅ Всё установлено!            ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "  Сейчас запустится Claude Code."
echo "  Он попросит залогиниться — войди через claude.ai"
echo ""
echo "  После входа напиши ему:  setup"
echo "  Он доустановит всё остальное."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ─── 7. Запускаем Claude Code ───
cd ~/Projects/gutbrain
claude
