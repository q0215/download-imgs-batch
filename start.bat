@echo off

echo �o�b�`�������J�n���܂��B

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

echo ���̓t�@�C���F%FILE%
echo �o�̓t�H���_�F%FOLDER%

set /p FLG=�t�@�C���_�E�����[�h���s���܂����H[y/n]�F

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
echo %FILE%�����݂��܂���B
goto END

:CANCEL
echo �t�@�C���_�E�����[�h���L�����Z������܂����B
goto END

:END
echo �o�b�`�������I�����܂����B
pause
exit 0
