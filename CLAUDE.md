# GutBrain — Claude Code Instructions

> Этот файл автоматически читается Claude Code при старте сессии

---

## О проекте

**GutBrain** — AI-компаньон для восстановления ЖКТ и ментального здоровья.
- iPhone-приложение (React Native + Expo)
- Backend: FastAPI + Claude API
- Целевая аудитория: женщины 25-35 с хроническими ЖКТ проблемами (СИБР, IBS)

---

## Структура проекта

```
gutbrain/
├── CLAUDE.md              ← Этот файл
├── app/                   ← React Native (Expo) — iPhone приложение
├── backend/               ← FastAPI сервер
├── docs/                  ← Документация и спеки
├── research/              ← Интервью и анализ
└── scripts/               ← Утилиты и автоматизация
```

---

## Обязательно прочитай

```
docs/GUTBRAIN_PRODUCT_SPEC.md       ← Полный продуктовый спек + план на 14 недель
research/analysis/BIO_INTERVIEW_ANALYSIS.md  ← Анализ интервью с пользователем
```

---

## Команда "setup"

Если пользователь пишет **"setup"**, **"настрой"**, **"установи всё"** или **"разверни проект"**:

1. Запусти скрипт: `bash scripts/setup.sh`
2. Если скрипт не найден — выполни шаги вручную (см. ниже)
3. После установки — покажи чек-лист что готово

### Ручная установка (если скрипт не работает):

```bash
# 1. Проверить Xcode Command Line Tools
xcode-select --install 2>/dev/null || true

# 2. Проверить/установить Homebrew
command -v brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Проверить/установить Node.js 18+
node --version || brew install node

# 4. Проверить/установить Python 3.11+
python3 --version || brew install python@3.12

# 5. Создать React Native приложение (Expo)
cd app && npx create-expo-app@latest . --template blank-typescript

# 6. Установить зависимости приложения
cd app && npm install

# 7. Создать Python окружение для бэкенда
cd backend && python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt

# 8. Проверить что Expo Go установлен на iPhone (напомнить пользователю)
```

---

## Технический стек

| Компонент | Технология | Зачем |
|-----------|-----------|-------|
| Mobile app | React Native + Expo | Кроссплатформа, быстрый старт |
| Navigation | Expo Router | File-based routing |
| State | Zustand | Простой, лёгкий |
| UI | React Native Paper или NativeWind | Material Design / Tailwind |
| Backend | FastAPI (Python) | Быстрый API, async |
| AI | Claude API (Sonnet) | Conversational AI |
| DB | PostgreSQL + pgvector | RAG, поиск по анамнезу |
| Auth | Supabase Auth | Google/Apple Sign-In |
| Storage | Supabase Storage | Фото анализов |

---

## Принципы разработки

1. **iPhone first** — делаем для iOS, Android потом
2. **OCD-safe design** — НИКОГДА не показывать raw метрики. Только actionable insights
3. **Conversational, не dashboard** — главный экран = чат, не графики
4. **Max 2 уведомления в день** — утренний ритуал + вечерний чекин
5. **Тон: спокойный наставник** — не toxic positivity, не sugarcoating

---

## Дизайн

- **Палитра:** teal (основной), coral (акцент), sage (фон), тёплые тона
- **Шрифт:** системный (San Francisco на iOS)
- **Стиль:** минимализм, много воздуха, скруглённые карточки
- **Иконки:** SF Symbols (iOS native)

---

## НЕ делать

- Не показывать калории (триггерит РПП)
- Не добавлять gamification (триггерит OCD)
- Не использовать красный цвет для "плохих" показателей
- Не делать leaderboard / сравнение с другими
- Не хранить медицинские данные без шифрования
