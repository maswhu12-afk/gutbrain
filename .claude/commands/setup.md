# Полная настройка рабочего окружения GutBrain

Выполни ВСЕ шаги последовательно. После каждого шага сообщай пользователю что сделано.

---

## Шаг 1: Системные зависимости

Запусти скрипт автоматической установки:

```bash
bash scripts/setup.sh
```

Если скрипт завершился с ошибкой, выполни шаги вручную:

1. Xcode Command Line Tools: `xcode-select --install`
2. Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
3. Node.js 18+: `brew install node`
4. Python 3.11+: `brew install python@3.12`

---

## Шаг 2: Проект приложения (Expo)

Если папки `app/` нет или в ней нет `package.json`:

```bash
cd app && npx --yes create-expo-app@latest . --template blank-typescript
```

Если `app/package.json` есть но нет `node_modules`:

```bash
cd app && npm install
```

---

## Шаг 3: Python бэкенд

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
deactivate
```

Если `backend/.env` не существует, создай шаблон:

```
ANTHROPIC_API_KEY=sk-ant-ЗАМЕНИ_НА_СВОЙ_КЛЮЧ
DATABASE_URL=postgresql://user:password@localhost:5432/gutbrain
SECRET_KEY=ЗАМЕНИ_НА_СЛУЧАЙНУЮ_СТРОКУ
```

---

## Шаг 4: Установка скиллов Claude Code

Проверь, доступен ли скилл `/pdf`. Если нет — скажи пользователю:

```
Для работы с PDF документами нужно установить плагин.
Напиши в Claude Code:  /install-plugin anthropic-agent-skills
После установки перезапусти Claude Code (выйди и зайди снова).
```

---

## Шаг 5: Проверка Git

Проверь что git настроен:

```bash
git config user.name
git config user.email
```

Если пусто — попроси пользователя ввести своё имя и email:

```bash
git config --global user.name "Имя Фамилия"
git config --global user.email "email@example.com"
```

---

## Шаг 6: Финальный чек-лист

Покажи результат в виде таблицы:

| Компонент | Статус |
|-----------|--------|
| Xcode CLT | (проверь: `xcode-select -p`) |
| Homebrew | (проверь: `brew --version`) |
| Node.js | (проверь: `node --version`, нужен 18+) |
| Python | (проверь: `python3 --version`, нужен 3.11+) |
| Expo приложение | (проверь: `ls app/package.json`) |
| Python бэкенд | (проверь: `ls backend/.venv/bin/python`) |
| .env конфиг | (проверь: `ls backend/.env`) |
| Git | (проверь: `git config user.name`) |

---

## Шаг 7: Следующие шаги

Скажи пользователю:

```
Всё установлено! Вот что делать дальше:

1. Установи "Expo Go" на iPhone (App Store → поиск → Expo Go)

2. Запусти приложение:
   Напиши мне: "запусти приложение"
   Или вручную: cd app && npx expo start

3. Отсканируй QR-код камерой iPhone — приложение откроется

4. Прочитай продуктовый спек:
   Напиши мне: "расскажи про продукт"
```
