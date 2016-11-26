@echo off
setlocal

echo バッチを開始します。

cd /d %~dp0

set FOLDER=%~dp0output

if not "%1" == "" (
  set FILE=%~dp0%1
) else (
  set FILE=%~dp0input.txt
)

if not exist "%FILE%" (
  goto NO_INPUT_FILE
)

echo 入力ファイル：%FILE%
echo 出力フォルダ：%FOLDER%

set /p FLG=ダウンロードを行いますか？[y/n]：

if not "%FLG%"=="y" (
  GOTO CANCEL
)

if not exist %FOLDER%\ (
  mkdir %FOLDER%
)

set TASK=TASK

for /f "delims= eol=" %%X in (%FILE%) do (
  call :DOWNLOAD_FILE %%X
)

goto END

:DOWNLOAD_FILE
for /f "tokens=2* delims=/" %%i in ("%1") do (
  echo %%j | findstr \/ > nul
  if errorlevel 1 (
    call bitsadmin.exe /TRANSFER %TASK% %%X %FOLDER%\%%j > nul
    if errorlevel 0 (
      echo 正常：%%X
    ) else (
      echo 異常：%%X
    )
    exit /b 0
  ) else (
    call :DOWNLOAD_FILE %%i/%%j
    exit /b 1
  )
)
exit /b 1

:NO_INPUT_FILE
echo %FILE%が存在しません。
goto END

:CANCEL
echo ダウンロードがキャンセルされました。
goto END

:END
echo バッチを終了しました。
pause
exit 0
