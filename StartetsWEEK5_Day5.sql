SHOW variables LIKE '%auto';
SET autocommit=FALSE;
SHOW VARIABLES LIKE '%auto%';


/*
원자성- 트랜잭션은 1개 단일 작업
격리성 - 현재 트랜잭션 수행 중에 다른 트랜잭션 개입하지 못한다
일관성
영속성- 트랜잭션 성공- 영구 DB저장
메뉴 - 고객 -주문(메뉴 수량- 1. 고객 잔액 , 주문완료)
*/

-- 사용자 COMMIT/ ROLLBACK
-- DML(INSERT/update/delete/select( commit/ rollback
-- ddl(auto commit)

SELECT * FROM emp_copy WHERE employee_id=300;
DELETE FROM emp_copy WHERE employee_id=300;
ROLLBACK;
SELECT * FROM emp_copy WHERE employee_id=300;
SELECT * FROM emp_copy WHERE employee_id=301;
DELETE FROM emp_copy WHERE employee_id=301;
COMMIT;

-- 계좌이체
Drop TABLE account_tbl;
CREATE TABLE account_tbl
(account_number CHAR(10) PRIMARY KEY,
account_pw int,
balance DECIMAL(10, 2)
);

SELECT * from account_tbl;

INSERT INTO account_tbl
VALUES('a',1111,10000);
INSERT INTO account_tbl
VALUES('b',2222,0);

COMMIT;
SELECT * FROM account_tbl;

-- 계좌이체
-- 1. 자동 커밋
SET autocommit=TRUE;
UPDATE account_tbl
SET balance=balance-5000
WHERE account_number='A'; -- 10000


UPDATE account_tbl
SET balance= balance+5000
WHERE account_number='BB'; -- 0

ROLLBACK;
SELECT * FROM account_tbl;

-- 2.
SET autocommit=false;
UPDATE account_tbl
SET balance=balance-5000
WHERE account_number='A'; -- 10000


UPDATE account_tbl
SET balance= balance+5000
WHERE account_number='BB'; -- 0

ROLLBACK;
SELECT * FROM account_tbl;
COMMIT;
SET autocommit=TRUE;

SELECT * FROM emp_copy WHERE employee_id=400;

SELECT * FROM product;
DESC product;
INSERT INTO product VALUES(1,"스마트폰케이스",10000,10);


-- maria db char(길이), varchar(길이) -한글과 영문 모두 문자갯수
-- 한글 실제저장바이트 길이*3
-- oracle(char),oracle(varchar) - 바이트 수

SELECT * FROM emp_copy ;

SELECT * FROM users;

INSERT INTO users VALUES
('db', 'db','김전문','jun@kil.com','010-11112222','서울시 용산구 새싹캠퍼스'),
('oracle', 'oracl','최전문','jun2@kil.com','010-11312222','서울시 용산구 새싹캠퍼스'),
('mysql', 'mysql','박전문','jun3@kil.com','010-11412222','제주시 제주동  새싹캠퍼스'),
('sqlserver', 'sqlse','김전문','jun4@kil.com','010-15112222','부산시 용산구  새싹캠퍼스');

DESC users;

SELECT * FROM departments;
SELECT * FROM employees WHERE first_name="kimberely";
SELECT * FROM maxtest;

DROP TABLE maxtest;

SELECT * FROM locations;

SELECT SUM(salary),MONTH(hire_date) h FROM employees
GROUP BY month(hire_date)
having h!=3;


-- 명령프롬프트
-- mysql -u root -p 1234
-- create user jdbc@'%' identified by 'jdbc';
-- create database memberdb;
-- grant all privileges on memberdb.* to jdbc@'%';