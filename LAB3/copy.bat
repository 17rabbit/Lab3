@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul


mkdir Лабораторные\Группа\ФИО\batch
mkdir Лабораторные\Группа\ФИО\batch\скрытая_папка
mkdir Лабораторные\Группа\ФИО\batch\не_скрытая_папка


attrib +h "Лабораторные\Группа\ФИО\batch\скрытая_папка"


xcopy /?

xcopy /? > "Лабораторные\Группа\ФИО\batch\не_скрытая_папка\copyhelp.txt"

xcopy "Лабораторные\Группа\ФИО\batch\не_скрытая_папка\copyhelp.txt" "Лабораторные\Группа\ФИО\batch\скрытая_папка\copied_copyhelp.txt"

echo Операція завершена.