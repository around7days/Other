@echo off
title �ySQL�������s�c�[���z
echo �ySQL�������s�c�[���z

REM ���s�t�H���_�Ɉړ�
pushd %~dp0

REM ���s�\��SQL�\��
echo.
echo �u���s�\��SQL�i���s���j�v
dir /s /b | findstr -i -e "\.sql" | sort

REM Oracle�ڑ�������
echo Oracle�ڑ�����͂��Ă��������B��juser/pass@service
set /p i=Oracle�ڑ���F
set connectPass=%i%

REM �G���[�����m�F
echo.
echo �G���[�������ɏ������I�����܂����H
echo y:�͂� n:������

set /p j=���́F
if %k% == y goto run
goto end

REM SQL���s�_�C�A���O�\��
echo.
echo SQL�����s���܂����H
echo y:�͂� n:������

set /p j=���́F
if %j% == y goto run
goto end


REM ////////////////////////////////////////////////////////////////////////////////////////
:run

REM �ϐ��錾
set flowLog=���s�t���[.log
set sqlLog=���sSQL.log
set tempFile=temp_file.txt
set tempExeSql=temp_sql.txt

REM ��t�@�C���̐���
type nul > %flowLog%
type nul > %sqlLog%
type nul > %tempFile%
type nul > %tempExeSql%

REM �����J�n���Ԃ̕\��
echo.
echo �y�����J�n���ԁz%date% %time%                   >> %flowLog%
echo �yOracle�ڑ���z%connectPass%                   >> %flowLog%
echo �y���s���e�z                                    >> %flowLog%

REM SQL���s�t�@�C�����X�g�̎擾
dir /s /b | findstr -i -e "\.sql" | sort             >> %tempFile%

REM SQL���s�t�@�C���̐���
echo whenever sqlerror exit failure rollback         >> %tempExeSql%
echo whenever oserror exit failure rollback          >> %tempExeSql%
echo set autocommit off                              >> %tempExeSql%
echo spool %sqlLog%                                  >> %tempExeSql%
echo set echo on                                     >> %tempExeSql%
for /F "delims=" %%a in (%tempFile%) do (
    echo @"%%a"                                      >> %tempExeSql%
    echo pause                                       >> %tempExeSql%
)
echo set echo off                                    >> %tempExeSql%
echo prompt ��[Enter]�R�񉟉��ŃR�~�b�g���܂��B      >> %tempExeSql%
echo prompt ���~�{�^�������Ń��[���o�b�N���܂��B     >> %tempExeSql%
echo prompt ��[ctrl + c]�̓R�~�b�g�����̂Œ��ӁI!  >> %tempExeSql%
echo pause                                           >> %tempExeSql%
echo pause                                           >> %tempExeSql%
echo pause                                           >> %tempExeSql%
echo commit;                                         >> %tempExeSql%
echo spool off                                       >> %tempExeSql%
echo exit;                                           >> %tempExeSql%

REM ���s�\����e�̕\��
echo ----------------------------------------------- >> %flowLog%
type %tempExeSql%                                    >> %flowLog%
echo ----------------------------------------------- >> %flowLog%

REM SQL�̎��s
sqlplus %connectPass% @%tempExeSql%

REM �����I�����Ԃ̕\��
echo �y�����I�����ԁz%date% %time%                   >> %flowLog%

REM �ꎞ�t�@�C���̍폜
del %tempFile%
del %tempExeSql%

REM ////////////////////////////////////////////////////////////////////////////////////////

:end
pause
