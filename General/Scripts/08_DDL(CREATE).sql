/*
- 데이터 딕셔너리란?
자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블
데이터 딕셔너리는 사용자가 테이블을 생성하거나 사용자를 변경하는 등의
작업을 할 때 데이터베이스 서버에 의해 자동으로 갱신되는 테이블


- User_tables : 자신의 계정이 소유한 객체 등에 관한 정보를 조회 할 수 있는 딕셔너리 뷰
*/
SELECT * FROM USER_TABLES;


--------------------------------------------------------------------------------------------------------------------

-- DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어

-- 객체(OBJECT)를 만들고(CREATE), 수정(ALTER)하고, 삭제(DROP) 등
-- 데이터의 전체 구조를 정의하는 언어로 주로 DB관리자, 설계자가 사용함

-- 오라클에서의 객체 : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
--                   인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER)
--                   프로시져(PROCEDURE), 함수(FUNCTION),
--                   동의어(SYNONYM), 사용자(USER)

--------------------------------------------------------------------------------------------------------------------

-- CREATE

-- 테이블이나 인덱스, 뷰 등 다양한 데이터베이스 객체를 생성하는 구문
-- 테이블로 생성된 객체는 DROP 구문을 통해 제거 할 수 있음 

-- 1. 테이블 생성하기
-- 테이블이란?
-- 행(row)과 열(column)으로 구성되는 가장 기본적인 데이터베이스 객체
-- 데이터 배이스 내에서 모든 데이터는 테이블을 통해서 저장된다.


-- [표현식] 
/*
    CREATE TABLE 테이블명 (
        컬럼명 자료형(크기), 
        컬럼명 자료형(크기),
        ...);
*/

/* 자료형
    NUMBER : 숫자형(정수, 실수)
    CHAR(크기) : "고정"길이 문자형 (2000BYTE) 
        -> ex) CHAR(10) 컬럼에 'ABC' 3BYTE 문자열만 저장해도 10BYTE 저장공간을 모두 사용. 
        
    VARCHAR2(크기) : "가변"길이 문자형 (4000 BYTE)
        -> ex) VARCHAR2(10) 컬럼에 'ABC' 3BYTE 문자열만 저장하면 나머지 7BYTE를 반환함.
        
    ** CHAR/VARCHAR2 주의사항 **
    - 오라클은 기본적으로 UTF-8 문자 인코딩을 사용하는데
      UTF-8은 영어/숫자 1BYTE,  한글 3BYTE로 저장하기 때문에
      한글 데이터 저장 시 크기 계산을 주의해야 한다!!!
      
    NVARCHAR2(문자 개수) : "가변" 길이 문자형 (4000BYTE)
     - BYTE크기 단위가 아닌 글자 수(문자 개수)로 크기를 지정하는 타입
        
    EX) VARCHAR2(3)  : 가변길이 문자형 크기 3BYTE    
        NVARCHAR2(3) : 가변길이 문자형 문자 3개까지 저장 가능
        

    DATE : 날짜 타입
    TIMESTAMP : 날짜 타입 (MS 단위 + UTC기준 시차)
    
    BLOB : 대용량 이진 데이터 (4GB)
    CLOB : 대용량 문자 데이터 (4GB)
*/

-- MEMBER 테이블 생성

-- 필요한 컬럼 : 아이디, 비밀번호, 이름, 주민등록번호, 가입일

/* *** MEMBER 테이블 설계 *** 
 * 
 *            컬럼명     /    자료형(크기)
 * 아이디  : MEMBER_ID    /  VARCHAR2(20BYTE)
 * 비밀번호 : MEMBER_PW    /  VARCHAR2(20BYTE)
 * 이름    : MEMBER_NAME  /  VARCHAR2(15BYTE) (한글 5자까지)
 * 주민등록번호: MEMBER_SSN /  CHAR(14BYTE)  (- 포함)
 * 가입일   : ENROLL_DATE /   DATE
 * */

CREATE TABLE "MEMBER"(
	MEMBER_ID VARCHAR2(20BYTE),
	MEMBER_PW VARCHAR2(20BYTE),
	MEMBER_NAME VARCHAR2(15BYTE),
	MEMBER_SSN CHAR(14BYTE),
	ENROLL_DATE DATE DEFAULT CURRENT_DATE -- 기본값 설정
);



-- 만든 테이블 확인
SELECT * FROM "MEMBER";


-- 2. 컬럼에 주석 달기
-- [표현식]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
COMMENT ON COLUMN "MEMBER".MEMBER_ID   IS '회원 아이디';
COMMENT ON COLUMN "MEMBER".MEMBER_PW   IS '회원 비밀번호';
COMMENT ON COLUMN "MEMBER".MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN "MEMBER".MEMBER_SSN  IS '회원 주민등록번호';
COMMENT ON COLUMN "MEMBER".ENROLL_DATE IS '회원 가입일';

-- 여러 SQL 한 번에 실행 : 블럭으로 선택 후 ALT + X

-- USER_TABLES : 사용자가 작성한 테이블을 확인 하는 뷰
-- 데이터 딕셔너리에 정의되어 있음
SELECT * FROM USER_TABLES;


-- DESC문 : 테이블의 구조를 표시 (SQLPLUS에서만 사용 가능)
DESC "MEMBER"; 

SELECT * FROM "MEMBER";


-- MEMBER 테이블에 샘플 데이터 삽입
INSERT INTO "MEMBER"
VALUES('MEM01', '123ABC', '홍길동', 
	   '990102-1234567', CURRENT_DATE);
-- 아이디, 비밀번호, 이름, 주민등록번호, 가입일

COMMIT; --> 트랜잭션 저장 내용 DB 반영	  
	  
--  데이터 삽입 확인
SELECT * FROM "MEMBER";


-- 추가 샘플 데이터 삽입
-- 가입일 -> SYSDATE/CURRENT_DATE 를 활용
INSERT INTO "MEMBER"
VALUES('MEM02', 'QWER1234', '김영희', '980808-2345678', CURRENT_DATE);

-- 가입일 -> DEFAULT 활용(테이블 생성 시 정의된 값이 반영됨)
INSERT INTO "MEMBER"
VALUES('MEM03', 'ASDFZXCV', '박철수', '970303-1234567', DEFAULT);
--> DEFAULT == 테이블 생성 시 지정한 DEFAULT 값(CURRENT_DATE)

-- 가입일 -> INSERT 시 미작성 하는 경우 -> DEAFULT 값이 반영됨
INSERT INTO "MEMBER"(MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_SSN)
VALUES('MEM04', '1Q2W3E4R', '신짱구', '960606-1234567');


--  데이터  삽입 확인
SELECT * FROM "MEMBER";


--------------------------------------------------------------------------------------------------------------------


-- 제약 조건(CONSTRAINTS)
/*
    사용자가 원하는 조건의 데이터만 유지하기 위해서 특정 컬럼에 설정하는 제약.
    데이터 무결성 보장을 목적으로 함.
    --> 무결성 보장 == 데이터의 신뢰도 확보

    + 입력 데이터에 문제가 없는지 자동으로 검사하는 목적
    + 데이터의 수정/삭제 가능여부 검사등을 목적으로 함 
        --> 제약조건을 위배하는 DML 구문은 수행할 수 없음!
    
    제약조건 종류
    PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY.
    
*/

-- 제약 조건 확인
-- USER_CONSTRAINTS : 사용자가 작성한 제약조건을 확인 하는 딕셔너리 뷰 
DESC USER_CONSTRAINTS;
SELECT * FROM USER_CONSTRAINTS;

-- USER_CONS_COLUMNS : 제약조건이 걸려 있는 컬럼을 확인 하는 딕셔너리 뷰 
DESC USER_CONS_COLUMNS;
SELECT * FROM USER_CONS_COLUMNS;



-- 1. NOT NULL 
-- 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용
-- 삽입/수정시 NULL값을 허용하지 않도록 컬럼레벨에서 제한

-- 컬럼 레벨 : 테이블 생성 시 생성할 컬럼의 정보를 작성하는 부분

CREATE TABLE USER_USED_NN(
    USER_NO NUMBER NOT NULL, -- 컬럼 레벨 제약 조건 설정
    
    USER_ID VARCHAR2(20) ,
    USER_PWD VARCHAR2(30) ,
    USER_NAME VARCHAR2(30) ,
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

SELECT * FROM USER_USED_NN;



INSERT INTO USER_USED_NN
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');


INSERT INTO USER_USED_NN
VALUES(NULL, NULL, NULL, NULL, NULL, '010-1234-5678', 'hong123@kh.or.kr');
--> NOT NULL 제약 조건에 위배되어 오류 발생 
-- ORA-01400: cannot insert NULL into ("KH"."USER_USED_NN"."USER_NO")


SELECT * FROM USER_USED_NN; -- 오류 안난 1행만 삽입됨을 확인
--------------------------------------------------------------------------------------------------------------------


-- 2. UNIQUE 제약조건 
-- 컬럼에 입력 값에 대해서 "중복을 제한"하는 제약조건
-- 컬럼레벨에서 설정 가능, 테이블 레벨에서 설정 가능
-- 단, UNIQUE 제약 조건이 설정된 컬럼에 NULL 값은 중복 삽입 가능.


-- UNIQUE 제약 조건 테이블 생성
CREATE TABLE USER_USED_UK(
    USER_NO NUMBER,
    
    -- USER_ID VARCHAR2(20) UNIQUE, -- 컬럼 레벨 제약 조건(제약 조건명 X) 
    
    USER_ID VARCHAR2(20) CONSTRAINT USER_ID_U UNIQUE,  -- 컬럼 레벨 제약 조건(제약 조건명 o)
    				 --  CONSTRAINT 제약조건명  제약조건종류
    				  --> 해당 컬럼에 "USER_ID_U" 라는 이름의
    				  --   UNIQUE 제약조건을 생성(설정)
    
    USER_PWD VARCHAR2(30) ,
    USER_NAME VARCHAR2(30), -- 테이블 레벨로 제약조건 설정하기
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    
    /* 테이블 레벨 : 테이블 생성 구문에서 컬럼 정의가 끝난 이후 부분 
     *  - 제약조건종류(컬럼) : 어떤 컬럼에 제약조건을 설정할지 작성
     * */
    
--	UNIQUE(USER_NAME) -- 테이블 레벨 제약 조건(제약 조건명 X)
    CONSTRAINT USER_NAME_U UNIQUE(USER_NAME) -- 테이블 레벨 제약 조건(제약 조건명 O)
);


INSERT INTO USER_USED_UK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_USED_UK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--> 같은 아이디인 데이터가 이미 테이블에 있으므로 UNIQUE 제약 조건에 위배되어 오류발생
--ORA-00001: 무결성 제약 조건(KH_BDH.USER_ID_U)에 위배됩니다

INSERT INTO USER_USED_UK
VALUES(1, NULL, 'pass01', '가길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--> 아이디에 NULL 값 삽입 가능.

INSERT INTO USER_USED_UK
VALUES(1, NULL, 'pass01', '나길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--> 아이디에 NULL 값 중복 삽입 가능.

INSERT INTO USER_USED_UK
VALUES(1, NULL, 'pass01', '나길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH_BDH.USER_NAME_U)에 위배됩니다

SELECT  * FROM USER_USED_UK; -- 3행 삽입 확인



-- 오류 보고에 나타나는 SYS_C008635 같은 제약 조건명으로
-- 해당 제약 조건이 설정된 테이블명, 컬럼, 제약 조건 타입 조회 
SELECT UCC.TABLE_NAME, UCC.COLUMN_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UCC.CONSTRAINT_NAME = UC.CONSTRAINT_NAME
AND UCC.CONSTRAINT_NAME = 'USER_NAME_U';


---------------------------------------


-- UNIQUE 복합키
-- 두 개 이상의 컬럼을 묶어서 하나의 UNIQUE 제약조건을 설정함
--> 복합키 설정은 오직 "테이블 레벨"에서만 가능!!
CREATE TABLE USER_USED_UK2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50) , -- 테이블 레벨 설정 전에 마지막 컬럼에 , 찍기!!!!!
    
    -- 테이블 레벨 복합키 설정
    CONSTRAINT USER_ID_NAME_U UNIQUE(USER_ID, USER_NAME)
);


INSERT INTO USER_USED_UK2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(2, 'user01', 'pass01', '고길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--> USER_NAME가 다름

INSERT INTO USER_USED_UK2
VALUES(2, 'user02', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--> USER_ID가 다름

INSERT INTO USER_USED_UK2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--> 여러 컬럼을 묶어서 UNIQUE 제약 조건이 설정되어 있으면 
-- 두 컬럼이 모두 중복되는 값일 경우에만 오류 발생
-- ORA-00001: 무결성 제약 조건(KH_BDH.USER_ID_NAME_U)에 위배됩니다


SELECT * FROM USER_USED_UK2;


----------------------------------------------------------------------------------------------------------------

-- 3. PRIMARY KEY(기본키) 제약조건 

-- ***테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미함***
-- ***테이블에 대한 식별자(IDENTIFIER) 역할을 함***

-- NOT NULL + UNIQUE 제약조건의 의미
-- 한 테이블당 한 개만 설정할 수 있음
-- 컬럼레벨, 테이블레벨 둘다 설정 가능함
-- 한 개 컬럼에 설정할 수도 있고, 여러개의 컬럼을 묶어서 설정할 수 있음
 --> 복합키 가능

CREATE TABLE USER_USED_PK(
    USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY, -- 컬럼 레벨 설정
    
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
    
    -- 테이블 레벨 설정
    --, CONSTRAINT USER_NO_PK PRIMARY KEY(USER_NO)
);


INSERT INTO USER_USED_PK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');


INSERT INTO USER_USED_PK
VALUES(1, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr');
--> 기본키 중복으로 오류
-- ORA-00001: 무결성 제약 조건(KH_BDH.USER_NO_PK)에 위배됩니다

INSERT INTO USER_USED_PK
VALUES(NULL, 'user03', 'pass03', '유관순', '여', '010-9999-3131', 'yoo123@kh.or.kr');
--> 기본키가 NULL 이므로 오류
-- ORA-01400: NULL을 ("KH_BDH"."USER_USED_PK"."USER_NO") 안에 삽입할 수 없습니다

---------------------------------------

-- PRIMARY KEY 복합키 (테이블 레벨만 가능)
CREATE TABLE USER_USED_PK2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT PK_USERNO_USERID PRIMARY KEY(USER_NO, USER_ID) -- 복합키
);

INSERT INTO USER_USED_PK2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(2, 'user01', 'pass01', '유관순', '여', '010-9999-3131', 'yoo123@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'user01', 'pass01', '신사임당', '여', '010-9999-9999', 'sin123@kh.or.kr');
-- 회원 번호와 아이디 둘다 중복 되었을 때만 제약조건 위배 에러 발생
-- ORA-00001: 무결성 제약 조건(KH_BDH.PK_USERNO_USERID)에 위배됩니다


SELECT * FROM USER_USED_PK2;

-- PRIMARY KEY는 NULL이 들어갈 수 없음
INSERT INTO USER_USED_PK2
VALUES(NULL, 'user01', 'pass01', '신사임당', '여', '010-9999-9999', 'sin123@kh.or.kr');
-- ORA-01400: NULL을 ("KH_BDH"."USER_USED_PK2"."USER_NO") 안에 삽입할 수 없습니다

----------------------------------------------------------------------------------------------------------------

/* 관계형 데이터베이스 핵심 */
-- 4. FOREIGN KEY(외부키 / 외래키) 제약조건 

-- 참조(REFERENCES)된 다른 테이블의 컬럼이 제공하는 값만 사용할 수 있음
-- FOREIGN KEY제약 조건에 의해서 테이블간의 관계(RELATIONSHIP)가 형성됨
-- 제공되는 값 외에는 NULL을 사용할 수 있음

-- 컬럼레벨일 경우
-- 컬럼명 자료형(크기) [CONSTRAINT 이름] 
-- REFERENCES 참조할 테이블명 [(참조할컬럼)] [삭제룰]

-- 테이블레벨일 경우
-- [CONSTRAINT 이름] FOREIGN KEY (적용할컬럼명) 
-- REFERENCES 참조할테이블명 [(참조할컬럼)] [삭제룰]

-- * 참조될 수 있는 컬럼은 PRIMARY KEY컬럼과, UNIQUE 지정된 컬럼만 
--   외래키로 사용할 수 있음

-- 참조할 테이블의 참조할 컬럼명이 생략이 되면, 
-- PRIMARY KEY로 설정된 컬럼이 자동 참조할 컬럼이 됨

CREATE TABLE USER_GRADE(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE VALUES (10, '일반회원');
INSERT INTO USER_GRADE VALUES (20, '우수회원');
INSERT INTO USER_GRADE VALUES (30, '특별회원');

SELECT * FROM USER_GRADE;

COMMIT;


CREATE TABLE USER_USED_FK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER -- 해당 컬럼에 작성될 수 있는 값은
  					-- USER_GRADE 테이블의 
  				    -- PK컬럼 값(GRADE_CODE)만 작성하게 제한하고 싶다!
  					--> FK 제약조건 설정
  
  /* 테이블 레벨 설정 */
  , CONSTRAINT GRADE_CODE_FK1 
    FOREIGN KEY (GRADE_CODE) 
    REFERENCES USER_GRADE (GRADE_CODE)
);


INSERT INTO USER_USED_FK
VALUES(1, 'user01', 'pass01', '홍길동', '남', 
'010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(2, 'user02', 'pass02', '이순신', '남', 
'010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(3, 'user03', 'pass03', '유관순', '여', 
'010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_USED_FK
VALUES(4, 'user04', 'pass04', '안중근', '남', 
'010-2222-1111', 'ahn123@kh.or.kr', null);
--> NULL 사용 가능.


SELECT * FROM USER_USED_FK;


INSERT INTO USER_USED_FK
VALUES(5, 'user05', 'pass05', '윤봉길', '남', 
'010-6666-1234', 'yoon123@kh.or.kr', 50);
--> 50이라는 값은 USER_GRADE 테이블 GRADE_CODE 컬럼에서 제공하는 값이 아니므로
 -- 외래키 제약 조건에 위배되어 오류 발생.

-- ORA-02291: 무결성 제약조건(KH_BDH.GRADE_CODE_FK1)이 위배되었습니다
-- - 부모 키가 없습니다

-- 부모 테이블 : 참조를 "당하는" 테이블 (USER_GRADE)
-- 자식 테이블 : 참조를 "하는"  테이블 (USER_USED_FK) 

---------------------------------------

-- * FOREIGN KEY 삭제 옵션 
-- 부모 테이블의 데이터 삭제 시 자식 테이블의 데이터를 
-- 어떤식으로 처리할 지에 대한 내용을 설정할 수 있다.

SELECT * FROM USER_GRADE;
SELECT * FROM USER_USED_FK;

-- 1) ON DELETE RESTRICTED(삭제 제한)로 기본 지정되어 있음
-- FOREIGN KEY로 지정된 컬럼에서 사용되고 있는 값일 경우
-- 제공하는 컬럼의 값은 삭제하지 못함

--> 자식 테이블 참조하고 있는 값은 
--  부모 테이블에서 삭제할 수 없다!!


-- GRADE_CODE 중 20은 외래키로 참조되고 있지 않으므로 삭제가 가능함.
SELECT * FROM USER_USED_FK; -- 자식
SELECT * FROM USER_GRADE;   -- 부모

DELETE 
FROM USER_GRADE 
WHERE GRADE_CODE = 20; -- 삭제 성공


SELECT * FROM USER_GRADE; -- 삭제 확인


/* 참조를 당하고 있는 값(GRADE_CODE) 10 삭제해보기 */
DELETE 
FROM USER_GRADE
WHERE GRADE_CODE = 10;
-- ORA-02292: 무결성 제약조건(KH_BDH.GRADE_CODE_FK1)이 위배되었습니다
-- - 자식 레코드가 발견되었습니다
 -- 자식 테이블인 USER_USED_FK 테이블에서
 -- GRADE_CODE 컬럼의 값 10을 참조하고 있기 때문에
 -- 삭제 불가!!



-- 2) ON DELETE SET NULL : 부모키 삭제시 자식키를 NULL로 변경하는 옵션
CREATE TABLE USER_GRADE2(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES (10, '일반회원');
INSERT INTO USER_GRADE2 VALUES (20, '우수회원');
INSERT INTO USER_GRADE2 VALUES (30, '특별회원');

SELECT * FROM USER_GRADE2;
COMMIT;

-- ON DELETE SET NUL 삭제 옵션이 적용된 테이블 생성
CREATE TABLE USER_USED_FK2(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  
  -- 컬럼 레벨로 FK 제약조건 작성
   --> 컬럼 레벨에서는 FOREIGN KEY 단어를 사용하지 않음!!!!!
  GRADE_CODE NUMBER 
  	CONSTRAINT GRADE_CODE_FK2
  	REFERENCES USER_GRADE2 (GRADE_CODE)
  	ON DELETE SET NULL -- 삭제 옵션 추가
);

--DROP TABLE USER_USED_FK2;


--샘플 데이터 삽입
INSERT INTO USER_USED_FK2
VALUES(1, 'user01', 'pass01', '홍길동', '남', 
'010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_USED_FK2
VALUES(2, 'user02', 'pass02', '이순신', '남', 
'010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_USED_FK2
VALUES(3, 'user03', 'pass03', '유관순', '여', 
'010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_USED_FK2
VALUES(4, 'user04', 'pass04', '안중근', '남', 
'010-2222-1111', 'ahn123@kh.or.kr', null);

COMMIT;

SELECT * FROM USER_GRADE2;
SELECT * FROM USER_USED_FK2;

-- 부모 테이블인 USER_GRADE2에서 GRADE_CODE = 10 삭제
--> ON DELETE SET NULL 옵션이 설정되어 있어 오류없이 삭제됨.
DELETE
FROM USER_GRADE2
WHERE GRADE_CODE = 10; -- 삭제 성공


SELECT * FROM USER_GRADE2; -- 10 삭제 확인
SELECT * FROM USER_USED_FK2; -- 10이 NULL로 변했는지 확인



-- 3) ON DELETE CASCADE : 부모키 삭제시 자식키도 함께 삭제됨
-- 부모키 삭제시 값을 사용하는 자식 테이블의 컬럼에 해당하는 행이 삭제가 됨

CREATE TABLE USER_GRADE3(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 VALUES (10, '일반회원');
INSERT INTO USER_GRADE3 VALUES (20, '우수회원');
INSERT INTO USER_GRADE3 VALUES (30, '특별회원');

-- ON DELETE CASCADE 삭제 옵션이 적용된 테이블 생성
CREATE TABLE USER_USED_FK3(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER
  
  -- 테이블 레벨 FK 제약조건 추가
  
  -- [CONSTRAINT 이름] 
  -- FOREIGN KEY (적용할컬럼명) 
  -- REFERENCES 참조할테이블명 [(참조할컬럼)] [삭제룰]

  , CONSTRAINT GRADE_CODE_FK3
  FOREIGN KEY(GRADE_CODE)
  REFERENCES USER_GRADE3 (GRADE_CODE) 
  ON DELETE CASCADE -- 부모 행 삭제 시 참조하던 자식 행 모두 삭제
);

--샘플 데이터 삽입
INSERT INTO USER_USED_FK3
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_USED_FK3
VALUES(2, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_USED_FK3
VALUES(3, 'user03', 'pass03', '유관순', '여', '010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_USED_FK3
VALUES(4, 'user04', 'pass04', '안중근', '남', '010-2222-1111', 'ahn123@kh.or.kr', null);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_USED_FK3;


-- 부모 테이블인 USER_GRADE3에서 GRADE_CODE =10 삭제
--> ON DELETE CASECADE 옵션이 설정되어 있어 오류없이 삭제됨.
DELETE 
FROM USER_GRADE3
WHERE GRADE_CODE = 10;

-- ON DELETE CASECADE 옵션으로 인해 참조키를 사용한 행이 삭제됨을 확인

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_USED_FK3;

COMMIT;

----------------------------------------------------------------------------------------------------------------

-- 5. CHECK 제약조건 : 컬럼에 기록되는 값에 조건 설정을 할 수 있음
-- CHECK (컬럼명 비교연산자 비교값)
-- 주의 : 비교값은 리터럴만 사용할 수 있음, 변하는 값이나 함수 사용 못함
CREATE TABLE USER_USED_CHECK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  
  -- 컬럼 레벨 설정
  GENDER VARCHAR2(10) 
  	CONSTRAINT GENDER_CHECK
  	CHECK (GENDER IN ('남', '여') ),
  	--> GENDER 컬럼에 저장되는 값이 '남' 또는 '여' 중 하나인지 검사
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);


INSERT INTO USER_USED_CHECK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_USED_CHECK
VALUES(2, 'user02', 'pass02', '홍길동', '남자', '010-1234-5678', 'hong123@kh.or.kr');
-- GENDER 컬럼에 CHECK 제약조건으로 '남' 또는 '여'만 기록 가능한데 '남자'라는 조건 이외의 값이 들어와 에러 발생
-- ORA-02290: 체크 제약조건(KH_BDH.GENDER_CHECK)이 위배되었습니다


-- CHECK 제약 조건은 범위로도 설정 가능.

 
 ----------------------------------------------------------------------------------------------------------------

-- [연습 문제]
-- 회원가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호) - 기본키(PK_USER_TEST), 
--         USER_ID(회원아이디) - 중복금지(UK_USER_ID),
--         USER_PWD(회원비밀번호) - NULL값 허용안함(NN_USER_PWD),
--         PNO(주민등록번호) - 중복금지(UK_PNO), NULL 허용안함(NN_PNO),
--         GENDER(성별) - '남' 혹은 '여'로 입력(CK_GENDER),
--         PHONE(연락처),
--         ADDRESS(주소),
--         STATUS(탈퇴여부) - NOT NULL(NN_STATUS), 'Y' 혹은 'N'으로 입력(CK_STATUS)
-- 각 컬럼의 제약조건에 이름 부여할 것
-- 5명 이상 INSERT할 것

/* 테이블 잘못 만들었을 경우 삭제 구문 수행!! */
DROP TABLE USER_TEST;


CREATE TABLE USER_TEST(
	USER_NO		NUMBER,
	USER_ID 	VARCHAR2(20),
	USER_PWD 	VARCHAR2(20) 
		-- NOT NULL은 컬럼 레벨만 가능!
		CONSTRAINT NN_USER_PWD NOT NULL, 
		
	PNO			CHAR(14)
		CONSTRAINT NN_PNO NOT NULL ,
	GENDER		CHAR(3),
	PHONE		CHAR(13),
	ADDRESS		VARCHAR2(300),
	STATUS		CHAR(1)
		CONSTRAINT NN_STATUS NOT NULL,
	
	-- 테이블 레벨
	CONSTRAINT PK_USER_TEST PRIMARY KEY(USER_NO), -- PK
	CONSTRAINT UK_USER_ID   UNIQUE(USER_ID),
	CONSTRAINT UK_PNO		UNIQUE(PNO),
	CONSTRAINT CK_GENDER    CHECK(GENDER IN ('남', '여')),
	CONSTRAINT CK_STATUS    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN USER_TEST.USER_NO IS '회원번호';
COMMENT ON COLUMN USER_TEST.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_TEST.USER_PWD IS '비밀번호';
COMMENT ON COLUMN USER_TEST.PNO IS '주민등록번호';
COMMENT ON COLUMN USER_TEST.GENDER IS '성별';
COMMENT ON COLUMN USER_TEST.PHONE IS '연락처';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '주소';
COMMENT ON COLUMN USER_TEST.STATUS IS '탈퇴여부';

INSERT INTO USER_TEST
VALUES(1, 'user01', 'pass01', '880122-1234567', '남', '010-1234-1234', NULL, 'N');
INSERT INTO USER_TEST
VALUES (2, 'user02', 'pass02', '890222-2234567', '여', '010-2222-9999', '서울시 강남구 삼성동', 'N');
INSERT INTO USER_TEST
VALUES (3, 'user03', 'pass03', '900322-2234567', '여', '010-3333-9999', '서울시 강남구 청담동', 'Y');
INSERT INTO USER_TEST
VALUES (4, 'user04', 'pass04', '910422-1234567', '남', '010-4444-9999', '서울시 강남구 도곡동', 'N');
INSERT INTO USER_TEST
VALUES (5, 'user05', 'pass05', '920522-2234567', '여', '010-5555-9999', '서울시 강남구 대치동', 'N');

SELECT * FROM USER_TEST;
----------------------------------------------------------------------------------------------------------------

-- 8. SUBQUERY를 이용한 테이블 생성
-- 컬럼명, 데이터 타입, 값이 복사되고, 제약조건은 NOT NULL 만 복사됨

-- 1) 테이블 전체 복사
CREATE TABLE EMPLOYEE_COPY
AS (SELECT * FROM EMPLOYEE);

SELECT * FROM EMPLOYEE_COPY;


-- 2) JOIN 후 원하는 컬럼만 테이블로 복사
CREATE TABLE EMPLOYEE_COPY2
AS SELECT 
		EMP_NAME,
		NVL(DEPT_TITLE, '부서없음') AS DEPT_TITLE,
		JOB_NAME
	FROM EMPLOYEE
	JOIN JOB USING(JOB_CODE)
	LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
	ORDER BY JOB_CODE ASC;

SELECT * FROM EMPLOYEE_COPY2;



-- 9. 제약조건 추가
-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] PRIMARY KEY(컬럼명)

-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] 
--  FOREIGN KEY(컬럼명) REFERENCES 참조 테이블명(참조컬럼명)
     --> 참조 테이블의 PK를 기본키를 FK로 사용하는 경우 참조컬럼명 생략 가능
                                                                                                                                                      
-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] UNIQUE(컬럼명)

-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] CHECK(컬럼명 비교연산자 비교값)

-- ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;

-- 테이블 제약 조건 확인
SELECT * 
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'EMPLOYEE_COPY';

-- NOT NULL 제약 조건만 복사된 EMPLOYEE_COPY 테이블에
-- EMP_ID 컬럼에 PRIMARY KEY 제약조건 추가
ALTER TABLE EMPLOYEE_COPY ADD CONSTRAINT PK_EMP_COPY PRIMARY KEY(EMP_ID);
-- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] PRIMARY KEY(컬럼명)

-- * 수업시간에 활용하던 테이블에는 FK 제약조건 없는상태이므로 추가!!

/*
 	ALTER TABLE 테이블명 
 	ADD [CONSTRAINT 제약조건명] 
	FOREIGN KEY(컬럼명) REFERENCES 참조 테이블명(참조컬럼명)
*/

-- EMPLOYEE테이블의 DEPT_CODE에 외래키 제약조건 추가
-- 참조 테이블은 DEPARTMENT, 참조 컬럼은 DEPARTMENT의 기본키
ALTER TABLE EMPLOYEE 
ADD CONSTRAINT DEPT_CODE_FK
FOREIGN KEY(DEPT_CODE)
REFERENCES DEPARTMENT;  -- 컬럼명 미작성 시 자동으로 PK 컬럼 참조
	-- 	== DEPARTMENT(DEPT_ID)

-- EMPLOYEE테이블의 JOB_CODE 외래키 제약조건 추가
-- 참조 테이블은 JOB, 참조 컬럼은 JOB의 기본키
ALTER TABLE EMPLOYEE
ADD CONSTRAINT JOB_CODE_FK
FOREIGN KEY(JOB_CODE)
REFERENCES JOB;



-- EMPLOYEE테이블의 SAL_LEVEL 외래키 제약조건 추가
-- 참조 테이블은 SAL_GRADE, 참조 컬럼은 SAL_GRADE의 기본키
ALTER TABLE EMPLOYEE
ADD CONSTRAINT SAL_LEVEL_FK
FOREIGN KEY(SAL_LEVEL)
REFERENCES SAL_GRADE;

-- DEPARTMENT테이블의 LOCATION_ID에 외래키 제약조건 추가
-- 참조 테이블은 LOCATION, 참조 컬럼은 LOCATION의 기본키
ALTER TABLE DEPARTMENT
ADD CONSTRAINT LOCATION_ID_FK
FOREIGN KEY(LOCATION_ID)
REFERENCES LOCATION;

-- LOCATION테이블의 NATIONAL_CODE에 외래키 제약조건 추가
-- 참조 테이블은 NATIONAL, 참조 컬럼은 NATIONAL의 기본키
ALTER TABLE LOCATION
ADD CONSTRAINT NATIONAL_CODE_FK
FOREIGN KEY(NATIONAL_CODE)
REFERENCES NATIONAL;
