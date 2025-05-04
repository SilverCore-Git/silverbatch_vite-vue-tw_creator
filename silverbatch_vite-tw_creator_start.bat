@echo off
title Vite + vue Creator

:title
echo.
echo "     ____ ___ _ __     _______ ____    ____    _  _____ ____ _   _     "
echo "    / ___|_ _| |\ \   / / ____|  _ \  | __ )  / \|_   _/ ___| | | |    "
echo "    \___ \| || | \ \ / /|  _| | |_) | |  _ \ / _ \ | || |   | |_| |    "
echo "     ___) | || |__\ V / | |___|  _ <  | |_) / ___ \| || |___|  _  |    "
echo "    |____/___|_____\_/  |_____|_| \_\ |____/_/   \_\_| \____|_| |_|    "
echo.


:tsorjs

echo Avec quelle langage veux-tu code ?
echo Tape 'ts' pour TypeScript ou 'js' pour JavaScript
set /p lang="> "

if /i "%lang%" neq "ts" if /i "%lang%" neq "js" (
    cls
    echo.
    echo.
    echo Choix invalide. Tape 'ts' pour TypeScript ou 'js' pour JavaScript.
    goto :tsorjs
) else (
    goto :twornot
)

:twornot

title Vite + vue-%lang% Creator


echo Veux-tu code avec tailwind css (y/n) ?
set /p iftailwind="> "

if /i "%iftailwind%" neq "y" if /i "%iftailwind%" neq "n" (
    cls
    echo.
    echo.
    echo Choix invalide. Tape 'y' pour oui ou 'n' pour non.
    goto :twornot
) else (
    goto :launch
)

:launch

setlocal

if /i "%iftailwind%"=="y" (

    title Vite + vue-%lang% + tailwind Creator

    set "PS1_PATH=assets/%lang%/vue-%lang%-tailwind.ps1"

) else (
    set "PS1_PATH=assets/%lang%/vue-%lang%.ps1"
)

:: Lancer le script PowerShell
powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1_PATH%"

endlocal

echo.
echo.
echo (Appuyez sur Entree pour fermer)
pause
