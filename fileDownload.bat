@echo off
setlocal

echo バッチ処理を開始します。

if "%2" == "" (
  echo バッチ起動時の引数が不正です。
  pause
  exit 1
)

set TASK=TASK
set URL=%1
set OUTPUT=%2

call :GET_FILENAME %URL%

:RTN
echo ファイル取得先URL：%URL%
echo 出力フォルダ：%OUTPUT%

bitsadmin.exe /TRANSFER %TASK% %URL% %OUTPUT%\%FILENAME%

echo バッチ処理を終了しました。
exit 0

:GET_FILENAME
for /f "tokens=2* delims=/" %%i in ("%1") do (
  echo %%j | findstr \/ > nul
  if errorlevel 1 (
    set FILENAME=%%j
    goto :RTN
  ) else (
    call :GET_FILENAME %%i/%%j
  )
)
pause
exit 1
