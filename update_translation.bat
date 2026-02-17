@echo off
chcp 65001 >nul
echo ========================================
echo  Warhammer 40K Rogue Trader 번역 업데이트
echo ========================================
echo.

setlocal EnableDelayedExpansion

set RELEASE_URL=https://github.com/ozt88/rogue-trader-korean-translation/releases/latest/download/enGB.json
set TEMP_FILE=%TEMP%\enGB_new.json

:: 가능한 경로 목록
echo [1/5] 게임 경로 검색 중...
echo.

set "PATH_1=E:\SteamLibrary\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization"
set "PATH_2=C:\Program Files (x86)\Steam\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization"
set "PATH_3=D:\SteamLibrary\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization"
set "PATH_4=C:\Steam\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization"

set GAME_PATH=

:: 자동 경로 찾기
if exist "%PATH_1%" set "GAME_PATH=%PATH_1%" & goto :found_path
if exist "%PATH_2%" set "GAME_PATH=%PATH_2%" & goto :found_path
if exist "%PATH_3%" set "GAME_PATH=%PATH_3%" & goto :found_path
if exist "%PATH_4%" set "GAME_PATH=%PATH_4%" & goto :found_path

:manual_select
echo 게임 설치 경로를 자동으로 찾을 수 없습니다.
echo.
echo 다음 중 해당하는 경로를 선택하세요 (또는 직접 입력):
echo   1. %PATH_1%
echo   2. %PATH_2%
echo   3. %PATH_3%
echo   4. %PATH_4%
echo   0. 직접 입력
echo.
set /p "choice=선택 (번호 입력): "

if "%choice%"=="0" goto :custom_path
if "%choice%"=="1" set "GAME_PATH=%PATH_1%" & goto :validate_path
if "%choice%"=="2" set "GAME_PATH=%PATH_2%" & goto :validate_path
if "%choice%"=="3" set "GAME_PATH=%PATH_3%" & goto :validate_path
if "%choice%"=="4" set "GAME_PATH=%PATH_4%" & goto :validate_path

echo.
echo [오류] 잘못된 선택입니다.
pause
exit /b 1

:custom_path
echo.
echo 전체 경로를 입력하세요
echo (예: D:\Games\Steam\steamapps\common\Warhammer 40,000 Rogue Trader\WH40KRT_Data\StreamingAssets\Localization)
set /p "GAME_PATH=경로: "

:validate_path
if not exist "%GAME_PATH%" (
    echo.
    echo [오류] 지정된 경로를 찾을 수 없습니다: %GAME_PATH%
    echo.
    set /p "retry=다시 시도하시겠습니까? (Y/N): "
    if /i "%retry%"=="Y" goto :manual_select
    pause
    exit /b 1
)

:found_path
echo [OK] 경로 확인: %GAME_PATH%
echo.

set BACKUP_PATH=%GAME_PATH%\enGB_backup_%date:~0,4%%date:~5,2%%date:~8,2%.json

echo [2/5] 최신 번역 파일 다운로드 중...
powershell -Command "Invoke-WebRequest -Uri '%RELEASE_URL%' -OutFile '%TEMP_FILE%' -UseBasicParsing" >nul 2>&1
if errorlevel 1 (
    echo [오류] 다운로드 실패. 인터넷 연결을 확인해 주세요.
    pause
    exit /b 1
)
echo [OK] 다운로드 완료
echo.

echo [3/5] 기존 파일 백업 중...
if exist "%GAME_PATH%\enGB.json" (
    copy "%GAME_PATH%\enGB.json" "%BACKUP_PATH%" >nul
    echo [OK] 백업 완료: enGB_backup_%date:~0,4%%date:~5,2%%date:~8,2%.json
) else (
    echo [정보] 기존 파일이 없어 백업을 걍단합니다.
)
echo.

echo [4/5] 새 번역 파일 적용 중...
copy "%TEMP_FILE%" "%GAME_PATH%\enGB.json" >nul
if errorlevel 1 (
    echo [오류] 파일 복사 실패. 관리자 권한으로 다시 실행해 주세요.
    pause
    exit /b 1
)
echo [OK] 적용 완료
echo.

echo [5/5] 임시 파일 정리 중...
del "%TEMP_FILE%" >nul 2>&1
echo [OK] 정리 완료
echo.

echo ========================================
echo  업데이트 완료! 게임을 실행해 보세요.
echo ========================================
echo.
echo 백업 파일: %BACKUP_PATH%
echo.
pause
