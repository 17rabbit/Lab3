@echo off
setlocal enabledelayedexpansion

rem Встановлення кодування UTF-8
chcp 65001 > nul

rem Перевірка наявності параметрів командного рядка для режиму підказки
if "%~1"=="" (
    echo Використання: %~nx0 ^<каталог^> [шаблон] [опції]
    echo Опції:
    echo   hidden      Включити приховані файли
    echo   reading   Включити файли тільки для читання
    echo   archive     Включити архівні файли
    exit /b 2
)

rem Обробка опцій командного рядка
set include_hidden=false
set include_readonly=false
set include_archive=false

for %%i in (%*) do (
    if "%%i"=="help" (
        echo Використання: %~nx0 ^<каталог^> [шаблон] [опції]
        echo Опції:
        echo   hidden      Включити приховані файли
        echo   reading   Включити файли тільки для читання
        echo   archive     Включити архівні файли
        exit /b 0
    ) else if "%%i"=="hidden" (
        set include_hidden=true
    ) else if "%%i"=="readonly" (
        set include_readonly=true
    ) else if "%%i"=="archive" (
        set include_archive=true
    )
)

rem Отримання каталогу та шаблону із аргументів командного рядка
set "directory=%~1"
set "pattern=*"
if "%~2" neq "" (
    set "pattern=%~2"
)

rem Підрахунок файлів у каталозі
set count=0

rem Встановлення параметрів для команди dir
set dir_cmd=dir /b /a:-h-r

rem Включення прихованих файлів, якщо прапор встановлено
if "%include_hidden%"=="true" (
    for /f "delims=" %%f in ('dir /b /a:h "%directory%\%pattern%"') do (
        set /a count+=1
    )
)

rem Включення файлів тільки для читання, якщо прапор встановлено
if "%include_readonly%"=="true" (
    for /f "delims=" %%f in ('dir /b /a:r "%directory%\%pattern%"') do (
        set /a count+=1
    )
)

rem Включення архівних файлів, якщо прапор встановлено
if "%include_archive%"=="true" (
    for /f "delims=" %%f in ('dir /b /a:a "%directory%\%pattern%"') do (
        set /a count+=1
    )
)

rem Підрахунок звичайних файлів
for /f "delims=" %%f in ('dir /b /a:-h-r "%directory%\%pattern%"') do (
    set /a count+=1
)

echo Кількість файлів, що відповідають шаблону '%pattern%' у каталозі '%directory%': %count%
echo Код завершення: 0
exit /b 0