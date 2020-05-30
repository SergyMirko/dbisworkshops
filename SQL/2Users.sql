ALTER TABLE DBPROJECT.USERS
 DROP PRIMARY KEY CASCADE;

DROP TABLE DBPROJECT.USERS CASCADE CONSTRAINTS;

CREATE TABLE DBPROJECT.USERS
(
  USER_ID     INTEGER,
  FIO         VARCHAR2(60 BYTE),
  BIRTH_DATE  DATE
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX DBPROJECT.USER_PK ON DBPROJECT.USERS
(USER_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;


CREATE OR REPLACE TRIGGER DBPROJECT."UserSeq" BEFORE INSERT ON DBPROJECT.USERS
FOR EACH ROW
WHEN (
new."USER_ID" IS NULL
      )
BEGIN
  SELECT USERS_SEQ.NEXTVAL 
  INTO :new."USER_ID" 
  FROM dual;
END;
/


ALTER TABLE DBPROJECT.USERS ADD (
  CONSTRAINT USER_PK
  PRIMARY KEY
  (USER_ID)
  USING INDEX DBPROJECT.USER_PK
  ENABLE VALIDATE);