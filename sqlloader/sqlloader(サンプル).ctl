----------------------------------------------------------------------
--  Oracle SQL*Loader Control File
----------------------------------------------------------------------
-- === SQL*Loader���s�I�v�V���� ===
OPTIONS(
  ROWS=1000     --1000�s�P�ʂŃR�~�b�g
 ,SKIP=1        --�擪�s�in�s�j���X�L�b�v
 ,ERRORS=1000   --���e����G���[�̐�
 ,DIRECT=TRUE   --�_�C���N�g���[�h�@�������ɂȂ邪���񂪑����炵��
)


-- === ���� ===
LOAD DATA


-- === �f�[�^�t�@�C���̕����R�[�h ===
CHARACTERSET JA16SJIS          --�����R�[�h�iJA16SJIS, JA16EUC, UTF8�j


-- === �f�[�^�t�@�C���� ===
INFILE      '�T���v��.csv' --�ǂݍ��݃t�@�C��
BADFILE     '�T���v��.bad' --�ǂݍ��݃G���[���R�[�h
DISCARDFILE '�T���v��.dsc' --���O�Ώۃ��R�[�h


-- === �f�[�^���[�h���[�h ===
TRUNCATE                      --�f�[�^����ւ��iINSERT, APPEND, REPLACE, TRUNCATE�j
PRESERVE BLANKS               --trim���Ȃ�


-- === INSERT�Ώۃe�[�u�� ===
INTO TABLE WORK_TBL1                                   --�����݃e�[�u��
WHEN (HINBAN <> "")                                    --�����ݏ���
--FIELDS TERMINATED BY X'09' OPTIONALLY ENCLOSED BY '"'  --��؂蕶���itsv�`���j�A�͂ݕ���(")
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'    --��؂蕶���icsv�`���j�A�͂ݕ���(")
TRAILING NULLCOLS                                      --�󔒂̏ꍇ��null��}��
(
  HINBAN
 ,DAIHYO_JIGYOBU_CD
 ,JIGYOBU_CD
 ,HINMEI
 ,HS_CD
)
