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
├── CLAUDE.md              ← Этот файл (auto-read)
├── .claude/
│   ├── commands/setup.md  ← Команда /project:setup
│   └── settings.json      ← Настройки проекта (скиллы)
├── app/                   ← React Native (Expo) — iPhone приложение
├── backend/               ← FastAPI сервер
├── docs/                  ← Документация и спеки
├── research/              ← Интервью, анализ, методология
└── scripts/               ← Утилиты и автоматизация
```

---

## Обязательно прочитай

```
docs/GUTBRAIN_PRODUCT_SPEC.md       ← Полный продуктовый спек + план на 14 недель
docs/PROJECT_HISTORY.md             ← Вся история разработки и данные исследований
research/analysis/BIO_INTERVIEW_ANALYSIS.md  ← Анализ интервью с пользователем
```

---

## Команда "setup" / "настрой" / "разверни"

Если пользователь пишет **"setup"**, **"настрой"**, **"установи всё"**, **"разверни проект"** или **"подготовь к работе"**:

**Выполни ВСЕ шаги последовательно:**

### 1. Системные зависимости

```bash
bash scripts/setup.sh
```

Если скрипт не найден или не работает — установи вручную:
1. `xcode-select --install` — Xcode Command Line Tools
2. Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
3. `brew install node` — Node.js 18+
4. `brew install python@3.12` — Python 3.11+

### 2. Expo приложение

```bash
# Если app/ пустая — создай проект:
npx --yes create-expo-app@latest app --template blank-typescript
# Если app/package.json есть — установи зависимости:
cd app && npm install
```

### 3. Python бэкенд

```bash
cd backend && python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt && deactivate
```

### 4. Конфиг (.env)

Если `backend/.env` не существует — создай шаблон с плейсхолдерами.

### 5. Git

Проверь `git config user.name` и `git config user.email`. Если пусто — попроси ввести.

### 6. Скиллы Claude Code

Проверь доступ к скиллу `pdf`. Если не доступен, скажи пользователю:
> Для работы с PDF и документами напиши: `/install-plugin anthropic-agent-skills`
> После установки выйди из Claude Code и зайди снова.

### 7. Финальный чек-лист

Покажи таблицу с результатами проверки всех компонентов. Напомни про Expo Go на iPhone.

---

## Команда "расскажи про продукт" / "что за проект"

Прочитай `docs/GUTBRAIN_PRODUCT_SPEC.md` и расскажи коротко:
- Что за приложение
- Для кого
- Основные функции
- План работ

---

## Команда "запусти приложение" / "run"

```bash
cd app && npx expo start
```

Скажи: "Отсканируй QR-код камерой iPhone (нужно приложение Expo Go)"

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
