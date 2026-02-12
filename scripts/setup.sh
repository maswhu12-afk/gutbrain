#!/bin/bash
# GutBrain — Автоматическая установка окружения
# Запуск: bash scripts/setup.sh

set -e

# Цвета
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
CHECK="${GREEN}✓${NC}"
CROSS="${RED}✗${NC}"
ARROW="${BLUE}→${NC}"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║     🧠 GutBrain — Setup Environment     ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Определяем корень проекта
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

ERRORS=0

# ─────────────────────────────────────────────
# 1. Xcode Command Line Tools
# ─────────────────────────────────────────────
echo -e "${ARROW} Проверяю Xcode Command Line Tools..."
if xcode-select -p &>/dev/null; then
    echo -e "  ${CHECK} Xcode CLT установлен"
else
    echo -e "  ${YELLOW}Устанавливаю Xcode Command Line Tools...${NC}"
    xcode-select --install 2>/dev/null || true
    echo -e "  ${YELLOW}⚠ Откроется окно установки. Дождись завершения и запусти скрипт снова.${NC}"
    exit 1
fi

# ─────────────────────────────────────────────
# 2. Homebrew
# ─────────────────────────────────────────────
echo -e "${ARROW} Проверяю Homebrew..."
if command -v brew &>/dev/null; then
    echo -e "  ${CHECK} Homebrew установлен ($(brew --version | head -1))"
else
    echo -e "  ${YELLOW}Устанавливаю Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Добавить в PATH для Apple Silicon
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    echo -e "  ${CHECK} Homebrew установлен"
fi

# ─────────────────────────────────────────────
# 3. Node.js
# ─────────────────────────────────────────────
echo -e "${ARROW} Проверяю Node.js..."
if command -v node &>/dev/null; then
    NODE_VER=$(node --version)
    NODE_MAJOR=$(echo "$NODE_VER" | cut -d. -f1 | tr -d 'v')
    if [ "$NODE_MAJOR" -ge 18 ]; then
        echo -e "  ${CHECK} Node.js $NODE_VER"
    else
        echo -e "  ${YELLOW}Node.js $NODE_VER слишком старый, обновляю...${NC}"
        brew install node
        echo -e "  ${CHECK} Node.js обновлён до $(node --version)"
    fi
else
    echo -e "  ${YELLOW}Устанавливаю Node.js...${NC}"
    brew install node
    echo -e "  ${CHECK} Node.js $(node --version) установлен"
fi

# ─────────────────────────────────────────────
# 4. Python
# ─────────────────────────────────────────────
echo -e "${ARROW} Проверяю Python..."
if command -v python3 &>/dev/null; then
    PY_VER=$(python3 --version | awk '{print $2}')
    PY_MAJOR=$(echo "$PY_VER" | cut -d. -f1)
    PY_MINOR=$(echo "$PY_VER" | cut -d. -f2)
    if [ "$PY_MAJOR" -ge 3 ] && [ "$PY_MINOR" -ge 11 ]; then
        echo -e "  ${CHECK} Python $PY_VER"
    else
        echo -e "  ${YELLOW}Python $PY_VER слишком старый, устанавливаю 3.12...${NC}"
        brew install python@3.12
        echo -e "  ${CHECK} Python 3.12 установлен"
    fi
else
    echo -e "  ${YELLOW}Устанавливаю Python...${NC}"
    brew install python@3.12
    echo -e "  ${CHECK} Python установлен"
fi

# ─────────────────────────────────────────────
# 5. Expo app
# ─────────────────────────────────────────────
echo -e "${ARROW} Настраиваю React Native приложение (Expo)..."
if [ -f "$PROJECT_ROOT/app/package.json" ]; then
    echo -e "  ${CHECK} Expo проект уже существует"
    cd "$PROJECT_ROOT/app"
    if [ ! -d "node_modules" ]; then
        echo -e "  ${YELLOW}Устанавливаю зависимости...${NC}"
        npm install
        echo -e "  ${CHECK} npm зависимости установлены"
    else
        echo -e "  ${CHECK} npm зависимости на месте"
    fi
else
    echo -e "  ${YELLOW}Создаю Expo проект...${NC}"
    cd "$PROJECT_ROOT"
    npx --yes create-expo-app@latest app --template blank-typescript
    echo -e "  ${CHECK} Expo проект создан"
fi

# ─────────────────────────────────────────────
# 6. Python виртуальное окружение + зависимости
# ─────────────────────────────────────────────
echo -e "${ARROW} Настраиваю Python бэкенд..."
cd "$PROJECT_ROOT/backend"

if [ ! -d ".venv" ]; then
    echo -e "  ${YELLOW}Создаю виртуальное окружение...${NC}"
    python3 -m venv .venv
    echo -e "  ${CHECK} .venv создан"
else
    echo -e "  ${CHECK} .venv уже существует"
fi

echo -e "  ${YELLOW}Устанавливаю Python зависимости...${NC}"
source .venv/bin/activate
pip install --quiet --upgrade pip
pip install --quiet -r requirements.txt
deactivate
echo -e "  ${CHECK} Python зависимости установлены"

# ─────────────────────────────────────────────
# 7. Файл .env (шаблон)
# ─────────────────────────────────────────────
echo -e "${ARROW} Проверяю .env..."
if [ ! -f "$PROJECT_ROOT/backend/.env" ]; then
    cat > "$PROJECT_ROOT/backend/.env" << 'ENVEOF'
# GutBrain Backend Configuration
# ⚠️ Заполни реальными значениями перед запуском!

ANTHROPIC_API_KEY=sk-ant-ЗАМЕНИ_НА_СВОЙ_КЛЮЧ
SUPABASE_URL=https://YOUR_PROJECT.supabase.co
SUPABASE_KEY=YOUR_SUPABASE_KEY
DATABASE_URL=postgresql://user:password@localhost:5432/gutbrain
SECRET_KEY=ЗАМЕНИ_НА_СЛУЧАЙНУЮ_СТРОКУ
ENVEOF
    echo -e "  ${CHECK} .env создан (⚠️  нужно заполнить ключи!)"
else
    echo -e "  ${CHECK} .env уже существует"
fi

# ─────────────────────────────────────────────
# ИТОГ
# ─────────────────────────────────────────────
cd "$PROJECT_ROOT"
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║           ✅ Установка завершена!        ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo -e " ${CHECK} Xcode Command Line Tools"
echo -e " ${CHECK} Homebrew"
echo -e " ${CHECK} Node.js $(node --version 2>/dev/null || echo '?')"
echo -e " ${CHECK} Python $(python3 --version 2>/dev/null | awk '{print $2}' || echo '?')"
echo -e " ${CHECK} Expo приложение (app/)"
echo -e " ${CHECK} Python бэкенд (backend/.venv)"
echo -e " ${CHECK} .env шаблон"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo " 📱 Следующие шаги:"
echo ""
echo "   1. Установи Expo Go на iPhone"
echo "      App Store → поиск → 'Expo Go' → установить"
echo ""
echo "   2. Заполни ключи в backend/.env"
echo "      (Анатолий даст API ключи)"
echo ""
echo "   3. Запусти приложение:"
echo "      cd app && npx expo start"
echo "      → Отсканируй QR-код камерой iPhone"
echo ""
echo "   4. Прочитай продуктовый спек:"
echo "      docs/GUTBRAIN_PRODUCT_SPEC.md"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
