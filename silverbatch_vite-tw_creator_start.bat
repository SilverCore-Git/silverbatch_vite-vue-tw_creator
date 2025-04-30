@echo off
title Vite + Tailwind CSS Creator

setlocal

:: Met ici le chemin complet vers ton fichier PS1
set "PS1_PATH=assets/silverbatch_vite_tw_creator.ps1"

:: Lancer le script PowerShell
powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1_PATH%"

endlocal
pause
