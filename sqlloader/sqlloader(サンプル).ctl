----------------------------------------------------------------------
--  Oracle SQL*Loader Control File
----------------------------------------------------------------------
-- === SQL*Loader実行オプション ===
OPTIONS(
  ROWS=1000     --1000行単位でコミット
 ,SKIP=1        --先頭行（n行）をスキップ
 ,ERRORS=1000   --許容するエラーの数
 ,DIRECT=TRUE   --ダイレクトモード　※高速になるが制約が多いらしい
)


-- === お約束 ===
LOAD DATA


-- === データファイルの文字コード ===
CHARACTERSET JA16SJIS          --文字コード（JA16SJIS, JA16EUC, UTF8）


-- === データファイル名 ===
INFILE      'サンプル.csv' --読み込みファイル
BADFILE     'サンプル.bad' --読み込みエラーレコード
DISCARDFILE 'サンプル.dsc' --除外対象レコード


-- === データロードモード ===
TRUNCATE                      --データ入れ替え（INSERT, APPEND, REPLACE, TRUNCATE）
PRESERVE BLANKS               --trimしない


-- === INSERT対象テーブル ===
INTO TABLE WORK_TBL1                                   --書込みテーブル
WHEN (HINBAN <> "")                                    --書込み条件
--FIELDS TERMINATED BY X'09' OPTIONALLY ENCLOSED BY '"'  --区切り文字（tsv形式）、囲み文字(")
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'    --区切り文字（csv形式）、囲み文字(")
TRAILING NULLCOLS                                      --空白の場合にnullを挿入
(
  HINBAN
 ,DAIHYO_JIGYOBU_CD
 ,JIGYOBU_CD
 ,HINMEI
 ,HS_CD
)
