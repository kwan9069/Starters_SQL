--1 이사원 15000 2022-12-26 10 삽입
/*INSERT INTO 테이블명(컬럼명 리스트 ...) VALUES (값 리스트 ...) */

INSERT INTO emp_copy(employee_id,first_name,last_name,salary,hire_date,department_id) VALUES (1,"사원","이",15000,'2022-12-26',10);

SELECT * FROM emp_copy ORDER BY EMPLOYEE_ID;


--2 최사원 15000 2022-12-26 80 삽입
INSERT INTO emp_copy VALUES (2,"사원","최",15000,'2022-12-26',80);

SELECT * FROM emp_copy ORDER BY EMPLOYEE_ID;

--3 홍길동 NULL NULL NULL(emp_copy 이미 입사일 NOT NULL 조건 설정)
INSERT INTO emp_copy VALUES (3,"길동","홍",null,'2022-12-26',null);

SELECT * FROM emp_copy ORDER BY EMPLOYEE_ID;

--4 김길동 NULL NULL NULL(emp_copy 이미 입사일 NOT NULL 조건 설정)
INSERT INTO emp_copy(employee_id,first_name,last_name,hire_date) VALUES (4,"길동","김홍",'2022-12-26' );

SELECT * FROM emp_copy ORDER BY EMPLOYEE_ID;


--여러개 insert
INSERT INTO emp_copy VALUES
(5,"길동","홍",7000,'2012-11-26',NULL),
(6,"길동","홍",NULL,'2012-11-26',NULL),
(7,"길동","홍",NULL,'2012-11-26',50);

SELECT * FROM emp_copy ORDER BY EMPLOYEE_ID;

--오류
INSERT INTO emp_copy VALUES
(5,"길동","홍",7000,'2012',NULL);

--년도 4자리-월2-일2 2시:2분:2초 mariadb 기본형식
--DATETIME(DATE,TIME)

INSERT ignore INTO emp_copy VALUES
(8,"길동","홍",7000,'2012',NULL);

SELECT * FROM emp_copy ORDER BY employee_id;

DESC emp_copy;

--emp_copy 테이블 생성+ 데이터 복사
CREATE TABLE emp_copy
SELECT employee_id, first_name, last_name, salary, hire_date, department_id FROM employees;

--emp_copy 테이블 생성하지 말고 + 데이터 복사
INSERT INTO emp_copy
SELECT employee_id, first_name, last_name, salary, hire_date, department_id FROM employees;

--커밋 상태 확인
SHOW VARAIABLES LIKE 'AUTO %'

--마리아 디비 auto commit 기본
/* insert
update
--delete
즉각 결과 반영
*/

SET AUTOCOMMIT -FALSE;

CREATE TABLE TEST( ID
INT PRIMARY KEY);

--SELECT * FROM 테이블명 
--DELETE FROM 테이블명 WHERE 조회|삭제조건식 문법 유사;

--DELETE 문장은 AUTOCOMMIT 상태 설정 변경하면 복구 기회 SQL
--WHERE 절 사용

--TRUNCATE 문장은 AUTOCOMMIT 상태 설정 변경해도 무시, 복구 기회 없는 SQL
--WHERE 절 사용 불가

TRUNCATE emp_copy;

/*UPDATE 테이블명
SET 변경 컬럼명=변경밧
WHERE 변경조건식 문법 유사*/

--1번 사번 사원의 급여 인상, 10% 인상
UPDATE emp_copy
SET SALARY=SALARY*1.1
WHERE EMPLOYEE_ID=1;

SELECT * FROM emp_copy ORDER BY employee_id;


--입사월이 6월 사원 부선 20번 부서 배정하고 급여 20% 인상-- 테이블 변경
UPDATE emp_copy 
SET DEPARTMENT_ID=20,SALARY=SALARY*1.2
WHERE HIRE_DATE LIKE '_____06%'
--SELECT HIRE_DATE,FIRST_NAME,DEPARTMENT_ID,SALARY FROM EMP_COPY

SELECT HIRE_DATE,FIRST_NAME,DEPARTMENT_ID,SALARY FROM EMP_COPY WHERE HIRE_DATE LIKE '_____06%';

--7장 제약조건
INSERT INTO emp_copy VALUES(9,'이름','성',NULL,NULL,NULL);

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='EMPLOYEES';
--WHERE TABLE_NAME='EMP_COPY';

--EMPLOYEE_ID,LAST_NAME,HIRE_DATE NOT NULL 조건 이미 설정
DESC emp_copy;

--PRIMARY,NOT NULL 정보
CREATE TABLE PRODUCT( P_CODE INT PRIMARY KEY, P_NAME CHAR(30) NOT NULL,PRICE DECIMAL,BALANCE SMALLINT CHECK(BALANCE >=0));

DESC PRODUCT;

--NOT NULL 제외 제약조건 정보
USE INFORMATION_SCHEMA;

SELECT * FROM TABLE_CONSTRAINTS WHERE TABLE_NAME='PRODUCT';

USE empdb;

INSERT INTO product VALUES(100,'냉장고',1000000,10);

SELECT * FROM product;

INSERT INTO product VALUES(101,'키보드',120000,-10); --마지막 0보다 커야 함
INSERT INTO product VALUES(102,'마우스',10000,50);
INSERT INTO product VALUES(104,'컴퓨터',130000,0);
SELECT * FROM product;

--p_code 정수, 자동숫자증가
--auto INCREMENT(컬럼 이미 존재 PRIMARY KEY 설정)

ALTER TABLE product modify p_code INT NOT NULL AUTO_INCREMENT;

INSERT INTO product(p_name,price,balance) VALUES('컴퓨터2',100000,50);
SELECT * FROM product;

--회원정보 저장 테이블
--users 테이블
/* user_id char(10) 중복 x,null 허용 x
user_pw 문자 5자리 null 허용 x, 
user_name 문자 30자리, user_email 문자 30자리, 중복 x
user_phone 문자 12자리 중복 x, address 문자 100자리*/
CREATE TABLE users(user_id CHAR(10) PRIMARY KEY, user_pw CHAR(5) NOT NULL, user_name CHAR(30),user_email CHAR(30) unique, user_phone CHAR(12) UNIQUE CHECK(user_phone LIKE '010-%') ,user_address CHAR(100));

DESC users; --컬럼명 타입, not null, primary 정보

--CHECK 설정 여부 포함(NOT NULL 제외) 정보
SELECT * FROM table_constraints wehre TABLE NAME='users';

--CHECK 내용
SELECT TABLE_NAME,CONSTRAINT_NAME,check_clause FROM information_schema.check_constraints;

--효력발생 DML
INSERT INTO users VALUES('maria','db','홍길동','hong@a.com','010-23456789','서울시 용산구');
INSERT INTO users VALUES('maria2','db','홍길동','hong2@a.com','010-34567890','서울시 용산구');
--CHECK 제약 조건 위배 INSERT INTO users VALUES('maria3','db3','홍길동','hong2@a.com','011334567890','서울시 용산구');

SELECT * FROM users;

--4,5 SELECT
--6 INSERT,DELETE,UPDATE
--7 제약조건 

--컬럼레벨로만 가능 -not null
--테이블레벨로만 가능(maria db만 -foreign key)
--컬럼레벨 + 테이블 레벨도 가능 PRIMARY KEY, UNIQUE, check

CREATE TABLE board(seq INT NOT NULL auto_increment PRIMARY KEY, --컬럼 레벨 정의
title CHAR(100) NOT NULL,   -- 컬럼레벨 정의
contents TEXT, --65536 바이트
viewcount INT DEFAULT 0,  --컬럼레벨 정의
 writer CHAR(10), 
CONSTRAINT fk_board_writer FOREIGN KEY(writer) REFERENCES users(user_id)
); --테이블레벨 정의

-외래키 제약조건 확인
SELECT * FROM information_schema.key_column_usage WHERE TABLE_NAME="board";
/*
users user_id -pk 설정되어야만한다
writer 컬럼은 users user_id 타입 길이 일치해야 한다.
*/

CREATE TABLE board2(seq INT NOT NULL AUTO_INCREMENT, -- 컬럼 레벨 정의
title CHAR(100) NOT NULL,   -- 컬럼레벨 정의
contents TEXT, -- 65536 바이트
viewcount INT DEFAULT 0,  -- 컬럼레벨 정의
 writer CHAR(10), 
--  CONSTRAINT pk_board_seq
PRIMARY KEY(seq),  
CONSTRAINT fk_board_writer2 FOREIGN KEY(writer) REFERENCES users(user_id),
CHECK(컬럼 조건),
UNIQUE(컬러명)
); 

SELECT * FROM information_schema.key_column_usage WHERE TABLE_NAME="board2";

INSERT INTO BOARD(tITLE,CONTENTS,WRITER) VALUES("제목","내용",'maria');
INSERT INTO BOARD(tITLE,CONTENTS,WRITER) VALUES("제목2","내용2",'maria2');

SELECT * FROM board;

SELECT * FROM users;

DELETE FROM users 
-- select * from users
-- delete from users where
SELECT * FROM users where user_id='maria';

-- 2.자식테이블이 참조중인 테이터 삭제시 -자식도 같이 삭제/null
-- 오류 해결
-- 테이블 내 조건 변경
-- create table -2장(없는 테이블 정의)/ alter table -14 장(있는 테이블의 컬럼추가, 컬럼삭제, 컬럼제약조건 수정)

ALTER TABLE 테이블명 ADD xxxx;-- 없던 컬럼 추가
ALTER TABLE 테이블명 MODIFY A CHAR(10) xxxx; -- 있던 컬럼타입이나 길이 수정
ALTER TABLE 테이블명 ADD CONSTRAINT; -- 존재하는 컬럼의  없던 제약조건 추가
ALTER TABLE 테이블명 MODIFY CONSTRAINT; -- 있던 컬럼 제약조건 수정
ALTER TABLE 테이블명 DROP xxxx; -- 있던 컬럼 삭제
CREATE TABLE test(id INT PRIMARY KEY); --제약조건 삭제



-- 외래키 제약조건 있는 상태에서
-- 외래키 제약조건 삭제후 - 추가 ON DELETE CASCADE 추가

ALTER TABLE board DROP CONSTRAINT fk_board_writer;
ALTER TABLE board Add constraint fk_board_writer
 FOREIGN KEY(writer) REFERENCES users(user_id)
 ON DELETE CASCADE ON UPDATE cascade;
 
 
 DELETE FROM users
 WHERE user_id='maria';
 
 SELECT * FROM users;
 SELECT * FROM board;



CREATE TABLE TEST(id INT PRIMARY KEY);

--CHECK 포함 (NOT null 제외)
