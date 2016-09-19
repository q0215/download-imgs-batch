@echo off

echo バッチ処理を開始します。

cd /d %~dp0

set FOLDER=%~dp0output

if not "%1" == "" (
  set FILE=%~dp0%1
) else (
  set FILE=%~dp0input.txt
)

if not exist "%FILE%" (
  goto NOFILE
)

echo 入力ファイル：%FILE%
echo 出力フォルダ：%FOLDER%

set /p FLG=ファイルダウンロードを行いますか？[y/n]：

if not "%FLG%"=="y" (
  GOTO CANCEL
)

if not exist %FOLDER%\ (
  mkdir %FOLDER%
)

for /f "delims= eol=" %%X in (%FILE%) do (
  start /w fileDownload.bat %%X %FOLDER%
)

goto END

:NOFILE
echo %FILE%が存在しません。
goto END

:CANCEL
echo ファイルダウンロードがキャンセルされました。
goto END

:END
echo バッチ処理を終了しました。
pause
exit 0
