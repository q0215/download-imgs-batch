@echo off
setlocal

echo �o�b�`�������J�n���܂��B

if "%2" == "" (
  echo �o�b�`�N�����̈������s���ł��B
  pause
  exit 1
)

set TASK=TASK
set URL=%1
set OUTPUT=%2

call :GET_FILENAME %URL%

:RTN
echo �t�@�C���擾��URL�F%URL%
echo �o�̓t�H���_�F%OUTPUT%

bitsadmin.exe /TRANSFER %TASK% %URL% %OUTPUT%\%FILENAME%

echo �o�b�`�������I�����܂����B
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
