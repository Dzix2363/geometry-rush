@echo off
chcp 65001 >nul

echo Uruchamianie dodatków w tle...

:: Odpalamy plik VBS, który po cichu włączy dodatek.bat
if exist "addons\start.vbs" (
    pushd "addons"
    wscript.exe start.vbs
    popd
) else (
    echo [OSTRZEŻENIE]: Nie znaleziono pliku addons\start.vbs
)

:: Uruchamianie pozostałych programów z pliku konfiguracja.txt (np. notatnik)
if exist "konfiguracja.txt" (
    for /f "tokens=*" %%i in (konfiguracja.txt) do (
        echo %%i | findstr /b /c:"#" >nul
        if errorlevel 1 (
            if not "%%i" == "" (
                start "" %%i
            )
        )
    )
)

:: Uruchomienie gry Geometry Rush
if exist "nwjs\nw.exe" (
    start "" "nwjs\nw.exe" "GraHTML"
) else (
    echo BŁĄD: Brak plików silnika! Rozpakuj pobrane NW.js bezpośrednio do folderu "nwjs".
    pause
)

exit