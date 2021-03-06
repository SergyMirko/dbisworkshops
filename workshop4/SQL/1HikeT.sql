ALTER TABLE DBPROJECT.HIKES
 DROP PRIMARY KEY CASCADE;

DROP TABLE DBPROJECT.HIKES CASCADE CONSTRAINTS;

CREATE TABLE DBPROJECT.HIKES
(
  HIKE_ID     INTEGER,
  HIKE_NAME   VARCHAR2(150 BYTE)                NOT NULL,
  DURATION    INTEGER                           NOT NULL,
  COMPLEXITY  INTEGER                           NOT NULL,
  LENGTH      FLOAT(126)                        NOT NULL,
  PRICE       INTEGER                           NOT NULL
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


--  There is no statement for index DBPROJECT.SYS_C0011983.
--  The object is created when the parent object is created.

CREATE UNIQUE INDEX DBPROJECT.HIKE_PK ON DBPROJECT.HIKES
(HIKE_ID)
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


CREATE OR REPLACE TRIGGER DBPROJECT.HIKESSEQ
BEFORE INSERT
ON DBPROJECT.HIKES
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN
-- For Toad:  Highlight column HIKE_ID
  :new.HIKE_ID := HIKES_SEQ.nextval;
END HIKESSEQ;
/


ALTER TABLE DBPROJECT.HIKES ADD (
  CONSTRAINT COMPLEXITY_CHEAK
  CHECK ("COMPLEXITY">0 AND "COMPLEXITY"<6)
  ENABLE VALIDATE,
  CONSTRAINT HIKE_PK
  PRIMARY KEY
  (HIKE_ID)
  USING INDEX DBPROJECT.HIKE_PK
  ENABLE VALIDATE,
  UNIQUE (HIKE_NAME)
  USING INDEX
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
  ENABLE VALIDATE);