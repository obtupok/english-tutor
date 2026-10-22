@echo off
rem Сайт Yomi на этом компьютере: http://localhost:8770
rem Первый раз открой личную ссылку из бота (/site -> "Ссылка для браузера"), заменив в ней
rem https://obtupok.github.io/english-tutor/ на http://localhost:8770/ - дальше ключ запомнится.
cd /d "%~dp0docs"
start "" http://localhost:8770/
python -m http.server 8770
