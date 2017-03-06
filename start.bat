@echo off
setlocal

echo �o�b�`���J�n���܂��B

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

echo ���̓t�@�C���F%FILE%
echo �o�̓t�H���_�F%FOLDER%

set /p FLG=�_�E�����[�h���s���܂����H[y/n]�F

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
      echo ����F%%X
    ) else (
      echo �ُ�F%%X
    )
    exit /b 0
  ) else (
    call :DOWNLOAD_FILE %%i/%%j
    exit /b 1
  )
)
exit /b 1

:NO_INPUT_FILE
echo %FILE%�����݂��܂���B
goto END

:CANCEL
echo �_�E�����[�h���L�����Z������܂����B
goto END

:END
echo �o�b�`���I�����܂����B
pause
exit 0
