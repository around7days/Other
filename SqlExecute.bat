@echo off
title 【SQL自動実行ツール】
echo 【SQL自動実行ツール】

REM 実行フォルダに移動
pushd %~dp0

REM 実行予定SQL表示
echo.
echo 「実行予定SQL（実行順）」
dir /s /b | findstr -i -e "\.sql" | sort

REM Oracle接続情報入力
echo Oracle接続を入力してください。例）user/pass@service
set /p i=Oracle接続先：
set connectPass=%i%

REM エラー処理確認
echo.
echo エラー発生時に処理を終了しますか？
echo y:はい n:いいえ

set /p j=入力：
if %k% == y goto run
goto end

REM SQL実行ダイアログ表示
echo.
echo SQLを実行しますか？
echo y:はい n:いいえ

set /p j=入力：
if %j% == y goto run
goto end


REM ////////////////////////////////////////////////////////////////////////////////////////
:run

REM 変数宣言
set flowLog=実行フロー.log
set sqlLog=実行SQL.log
set tempFile=temp_file.txt
set tempExeSql=temp_sql.txt

REM 空ファイルの生成
type nul > %flowLog%
type nul > %sqlLog%
type nul > %tempFile%
type nul > %tempExeSql%

REM 処理開始時間の表示
echo.
echo 【処理開始時間】%date% %time%                   >> %flowLog%
echo 【Oracle接続先】%connectPass%                   >> %flowLog%
echo 【実行内容】                                    >> %flowLog%

REM SQL実行ファイルリストの取得
dir /s /b | findstr -i -e "\.sql" | sort             >> %tempFile%

REM SQL実行ファイルの生成
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
echo prompt ◆[Enter]３回押下でコミットします。      >> %tempExeSql%
echo prompt ◆×ボタン押下でロールバックします。     >> %tempExeSql%
echo prompt ※[ctrl + c]はコミットされるので注意！!  >> %tempExeSql%
echo pause                                           >> %tempExeSql%
echo pause                                           >> %tempExeSql%
echo pause                                           >> %tempExeSql%
echo commit;                                         >> %tempExeSql%
echo spool off                                       >> %tempExeSql%
echo exit;                                           >> %tempExeSql%

REM 実行予定内容の表示
echo ----------------------------------------------- >> %flowLog%
type %tempExeSql%                                    >> %flowLog%
echo ----------------------------------------------- >> %flowLog%

REM SQLの実行
sqlplus %connectPass% @%tempExeSql%

REM 処理終了時間の表示
echo 【処理終了時間】%date% %time%                   >> %flowLog%

REM 一時ファイルの削除
del %tempFile%
del %tempExeSql%

REM ////////////////////////////////////////////////////////////////////////////////////////

:end
pause
