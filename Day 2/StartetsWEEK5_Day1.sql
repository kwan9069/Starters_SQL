#주석
--주석
여러줄 주석 
*/

--클릭은 Use empdb;
--employees 테이블 데이터 조회
SELECT * FROM employees;
SELECT * FROM departments;
SELECT employee_id,first_name FROM employees;
SELECT EMPLOYEE_ID AS 사번, FIRST_NAME AS 이름 FROM employees;
SELECT EMPLOYEE_ID "사 번", FIRST_NAME 이름 FROM employees; # "안에  띄워쓰기 가능

DESCRIBE employees;


SELECT first_name,salary FROM employees;

--연봉,salary*12

SELECT first_name, SALARY, salary*12 AS '연봉'  FROM employees;

--사원 속한 부서코드 종류 조회 -중복말고 1번
SELECT DISTINCT Department_id FROM employees;

select last_name,department_id
from employees
where department_id=80;

select employee_id,salary,first_name from employees where salary >= 10000 and employee_id< 200;

select salary,first_name from employees where salary >= 10000 and salary< 15000;

SELECT salary,first_NAME FROM employees WHERE salary BETWEEN 10000 AND 15000;

select first_name from employees;

-- db(maria db- 대소문자 구분 없다,'',"")

SELECT first_name from employees where first_name='steven';

-- s로 시작하는 사원 first_name 조회
SELECT first_name FROM employees WHERE first_name LIKE 's%';

--	ER로 끝나는 사람 조회
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%ER';

SELECT EMPLOYEE_ID,SALARY * 1.1 AS 인상급여
FROM employees
WHERE EMPLOYEE_ID IN(100,200,150,222);

-- 이름이 5글자 이면서 ER 끝나는 사원의

SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%ER' AND FIRST_NAME LIKE '___ER';

--입사일 조회 -datetime 형태
SELECT first_name,hire_date FROM employees;

DESC employees;

--2002년 입사자의 이름, 입사일 조회--문자열,날자형 - '',""
SELECT FIRST_NAME,HIRE_DATE FROM employees WHERE hire_date LIKE '2002%';

-- 6월 입사자 조회
SELECT FIRST_NAME,HIRE_DATE FROM employees WHERE hire_date LIKE '_____06%';

--커미션 받는 사원
SELECT FIRST_NAME,COMMISSION_PCT FROM employees WHERE commission_pct IS not NULL;
 
 --NULL 우선
SELECT EMPLOYEE_ID FROM employees  ORDER BY EMPLOYEE_ID LIMIT 8,4;

--NULL 나중
SELECT EMPLOYEE_ID,COMMISSION_PCT FROM employees ORDER BY EMPLOYEE_ID DESC;

--NULL 먼저,역순
SELECT EMPLOYEE_ID,COMMISSION_PCT FROM employees ORDER BY COMMISSION_PCT DESC;

--부서코드 오름차순, 동일 부서코드인 경우 급여 많은 사원부터 조회.
SELECT FIRST_NAME,SALARY,DEPARTMENT_ID FROM employees ORDER BY DEPARTMENT_ID,SALARY DESC;

--급여 총합 평균
SELECT SUM(SALARY),AVG(SALARY),COUNT(SALARY),MAX(SALARY),MIN(SALARY) FROM employees;

--입사일
SELECT COUNT(HIRE_dATE),MAX(HiRE_DATE),MIN(HIRE_DATE) FROM employees;


--커미션(null 많다)
SELECT COUNT(COMMISSION_PCT) FROM employees;

--NULL 포함 테이블 레코드
SELECT COUNT(*) FROM employees;

--
SELECT FIRST_NAME,DEPARTMENT_ID FROM employees
WHERE DEPARTMENT_ID IS NULL;

SELECT COUNT(DEPARTMENT_ID) FROM employees;

--사원이름,전체 사원 급여 총합 조회
SELECT FIRST_NAME,SUM(SALARY) FROM employees;

SELECT COUNT(DISTINCT DEPARTMENT_ID) FROM employees;

--50번 부서 사원 급여총합 조회
SELECT SUM(SALARY)
FROM employees
WHERE DEPARTMENT_ID=50;

--각 부서별 부서 사원 급여총합 조회
SELECT DEPARTMENT_ID,SUM(SALARY) FROM employees WHERE DEPARTMENT_ID GROUP BY DEPARTMENT_ID;

--각 부서별 부서 사원 급여총합 조회 , 단 부서코드 없는 사원 제외
SELECT DEPARTMENT_ID,SUM(SALARY) FROM employees WHERE DEPARTMENT_ID IS NOT NULL GROUP BY DEPARTMENT_ID;

--각 부서별,직종별 부서 사원 급여총합 조회 , 단 부서코드 없는 사원 제외
SELECT DEPARTMENT_ID,JOB_ID,SUM(SALARY) FROM employees WHERE DEPARTMENT_ID IS NOT NULL AND JOB_ID IS NOT NULL GROUP BY DEPARTMENT_ID,JOB_ID;

--각 부서별 부서 사원 급여총합 조회 , 단 부서코드 없는 사원 제외하고 급여총합 10만 이상인 부서만 조회
SELECT DEPARTMENT_ID,SUM(SALARY) FROM employees WHERE DEPARTMENT_ID IS NOT NULL GROUP BY DEPARTMENT_ID HAVING SUM(SALARY)>100000 ORDER BY 2 DESC;
--ORDER BY SUM(SALARY) DESC;

--DAY 1 실습
SELECT FIRST_NAME AS 이름 ,SALARY*12 AS "월급의 12배"  FROM employees WHERE SALARY*12>=170000;

SELECT FIRST_NAME,SALARY FROM employees WHERE MANAGER_ID IS NULL;

SELECT FIRST_NAME,SALARY,HIRE_DATE FROM employees WHERE HIRE_DATE <'2004-1-1 00:00:00';

SELECT DEPARTMENT_ID,DEPARTMENT_NAME FROM departments;

SELECT job_ID,JOB_TITLE FROM jobs;

SELECT FIRST_NAME,SALARY,DEPARTMENT_ID FROM employees WHERE SALARY>=13000;

SELECT FIRST_NAME,SALARY,DEPARTMENT_ID,HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE > "2005-12-31 00:00:00";

SELECT FIRST_NAME,SALARY,DEPARTMENT_ID FROM employees WHERE DEPARTMENT_ID= 50 OR DEPARTMENT_ID=80 HAVING SALARY>=13000;

SELECT FIRST_NAME,SALARY,DEPARTMENT_ID,HIRE_dATE FROM employees WHERE HIRE_DATE > "2005-12-31 00:00:00" HAVING SALARY >= 1300 AND SALARY <= 20000;

SELECT FIRST_NAME,SALARY,JOB_ID FROM employees WHERE HIRE_DATE> "__05%";

SELECT FIRST_NAME,SALARY,JOB_ID FROM employees WHERE JOB_ID LIKE "%CLERK%" OR JOB_ID LIKE "%CLERK";

SELECT FIRST_NAME,SALARY,HIRE_DATE FROM employees WHERE HIRE_dATE LIKE "_____12%";

SELECT FIRST_NAME,SALARY,HIRE_DATE FROM employees WHERE FIRST_NAME LIKE "%LE%";

SELECT FIRST_NAME,SALARY,HIRE_DATE FROM employees WHERE FIRST_NAME LIKE "%M";

SELECT FIRST_NAME,SALARY,HIRE_DATE FROM employees WHERE FIRST_NAME LIKE "__D%";

SELECT FIRST_NAME,COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

SELECT FIRST_NAME,COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;

SELECT FIRST_NAME,HIRE_DATE,SALARY FROM employees WHERE DEPARTMENT_ID= 30 OR DEPARTMENT_ID=50 OR DEPARTMENT_ID=80 AND COMMISSION_PCT IS NOT NULL HAVING SALARY>=5000 AND SALARY<= 17000 ORDER BY HIRE_DATE ASC, SALARY DESC;

SELECT DEPARTMENT_ID,MAX(SALARY),MIN(SALARY) FROM employees GROUP BY DEPARTMENT_ID HAVING MAX(SALARY) != MIN(SALARY);

SELECT DEPARTMENT_ID,COUNT(DEPARTMENT_ID) FROM employees GROUP BY DEPARTMENT_ID HAVING COUNT(DEPARTMENT_ID)>=5;

DESC employees; --테이블 컬럼들  조회


emp_copy CREATE TABLE emp_copy (SELECT employee_id, first_name, last_name, salary, hire_date, department_id FROM employees);

DESC emp_copy;

SELECT COUNT(*) FROM emp_copy;

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

--
CREATE TABLE PRODUCT( P_CODE INT PRIMARY KEY, P_NAME CHAR(30) NOT NULL,PRICE DECIMAL,BALANCE SMALLINT CHECK(BALANCE >=0));

DESC PRODUCT;

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='PRODUCT';

