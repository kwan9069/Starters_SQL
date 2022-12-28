USE EMPDB;

-- KELLY 급여 같은  사원의 이름, 급여 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY =(SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME='SUSAN' );


-- KELLY 보다 급여를 더 많이 많은 사원의 이름, 급여 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME='KELLY' );

-- 모든 WILLIAM 보다 급여를 더 많이 받는 사원의 이름, 급여 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ALL  (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME='WILLIAM' );


-- WILLIAM 중 1명보다 급여를 더 많이 받는 사원의 이름, 급여 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY  (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME='WILLIAM' );

-- WILLIAM  급여와 같은 급여를  받는 사원의 이름, 급여 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = ANY  (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME='WILLIAM' );
 
 -- "=ANY" ==> 
 
 
 
 
 
 WHERE SALARY IN (7400, 8300)
 WHERE SALARY =ANY (7400, 8300)
 
  -- WHERE SALARY =ALL (7400, 8300)
  
  -- 변수 사용
SET @NAME= 'PETER';

SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME=@NAME );


-- 부서의 최대급여 사원 이름 급여 조회
  
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM employees
WHERE (department_id , salary) IN 
(SELECT DEPartment_id, MAX(SALARY) FROM employees GROUP BY DEPARTmENT_ID)
ORDER BY department_id;

-- locations 테이블 부서 위치 도시 정보(런던)
-- departments 테이블 부서이름 부서장 도시코드
-- employees 테이블 사원이름(조회) ... 부서코드

-- subquery 중첩 - 테이블 여러개 필요

-- 런던 도시 근무 사원명 조회

--  1. 런던 도시코드 조회(2400)
SELECT location_id FROM locations WHERE city='london'; 

-- 2. 런던 도시코드 같은 도시코드 부서코드 조회(40)
SELECT * FROM departments;

SELECT department_id FROM departments WHERE location_id=2400;

-- 3.

SELECT first_name, department_id FROM employees
WHERE department_id=
							(SELECT department_id FROM departments WHERE location_id=
								(SELECT location_id FROM locations WHERE city='south san francisco' )
							);


-- 각 부서별 최대급여 이름급여 부서번호 조회
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM employees
WHERE (department_id , salary) IN 
(SELECT DEPartment_id, MAX(SALARY) FROM employees GROUP BY DEPARTmENT_ID)
ORDER BY department_id;

--  내  부서의 평균급여보 더 많이 받는 사원 급여 부서번호 조회
SELECT SALARY, DEPARTMENT_ID, 
(SELECT AVG(salary) FROM employees WHERE e.department_id=department_id  )
FROM employees e
WHERE salary > ANY (SELECT AVG(salary) FROM employees WHERE e.department_id=department_id  );


-- inline view
/*
select (select)
from (select 결과 1개 가상테이블 - inline view ) 
where (select)

*/


-- 10000 이상 급여 평균 

SELECT 3.AVG(salary)
FROM 1. employees
WHERE 2. salary >= 10000;

-- 회사 DB 부서별 권한 다르게 
SELECT SAL_TBL.AVG_SAL AS 고액월급평균
FROM (SELECT AVG(SALARY) AVG_SAL FROM employees WHERE SALARY >= 10000) SAL_TBL;


-- 급여 수준에 따른 직급 조회
-- EMPLOYEES 테이블 급여컬럼 있다 , 직급컬럼 없다
-- 직급 급여 20000 이상 임원, 15000 이상 부장, 10000 이상 과장 5000 이상대리  이하 사원
-- 급여 SALARY + SALARY * COMMISSION_PCT 
SELECT MAX(SALARY), MIN(SALARY) FROM employees;

SELECT FIRST_NAME, 
CASE 
WHEN SALARY + SALARY * IFNULL(COMMISSION_PCT, 0.1) >= 20000 THEN '임원'
WHEN SALARY + SALARY * COMMISSION_PCT >= 15000 THEN '부장'
WHEN SALARY + SALARY * COMMISSION_PCT >= 10000 THEN '과장'
WHEN SALARY + SALARY * COMMISSION_PCT >= 5000 THEN '대리'
ELSE "사원"
END 직급
FROM employees;

SELECT FIRST_NAME, SALARY, COMMISSION_PCT FROM employees;

-- NULL 값 컬럼 연산식 결과도 NULL--> IFNULL함수 다른값 변경 연산
-- 연산식 반복 

SELECT FIRST_NAME, 
CASE 
WHEN IMSISAL >= 20000 THEN "임원"
WHEN IMSISAL >= 15000 THEN '부장'
WHEN IMSISAL >= 10000 THEN '과장'
WHEN IMSISAL >= 5000 THEN '대리'
ELSE '사원'
END 직급
FROM (SELECT FIRST_NAME, SALARY + SALARY * IFNULL(COMMISSION_PCT, 0.1) AS IMSISAL FROM employees) IMSITBL;


-- 11시 20분


-- 
SELECT first_name, salary, (select Min(salary) FROM employees ) AS 최소급여  FROM employees;
 
-- update
-- emp_copy 

-- kelly 와 같은 부서의 사원의 부서 100번 이동
SELECT first_name, department_id FROM emp_copy WHERE department_id=20; -- 47명

UPDATE emp_copy
SET department_id = 100
WHERE department_id = (SELECT department_id FROM emp_copy WHERE first_name='kelly');

-- 100번 부서원을 susan의 부서로 이동
UPDATE emp_copy
SET department_id= (SELECT department_id FROM emp_copy WHERE FIRST_name='susan')
WHERE department_id=100;

-- delete .. where ()

-- 테이블 조합
-- 나누어져있다가
-- select시 합쳐서 조회

-- 조합 테이블 컬럼 갯수 타입 순서 일치

-- union / union all / intersect / minus(마리아db-except)

-- 50번 부서의 모든 부서원 복사 emp_dept_50 테이블 생성
CREATE TABLE emp_dept_50
(SELECT * FROM employees WHERE department_id=50);

-- manager 계열 직종 사원들을 emp_job_man 테이블 생성
-- job_id - IT_prog, st_man, it_man

CREATE TABLE emp_job_man
(SELECT * FROM employees WHERE job_id LIKE '%man%');


SELECT * FROM emp_dept_50;
SELECT * FROM emp_job_man;

-- 재난 지원금을 지원하려고 한다.
-- 대상은 50번 부서원이거나 manager 직종으로 한정하여 조회해 본다

SELECT employee_id, first_name, department_id, job_id
FROM emp_dept_50
union
SELECT employee_id, first_name, department_id, job_id
FROM emp_job_man
ORDER BY 1; -- 52

-- 재난 지원금을 지원하려고 한다.
-- 대상은 50번 부서원이거나 manager 직종으로 한정하여 조회해 본다
-- 50 부서이면서ㅏ manager 직종이면 중복 받을 수 있다
SELECT employee_id, first_name, department_id, job_id
FROM emp_dept_50
UNION all
SELECT employee_id, first_name, department_id, job_id
FROM emp_job_man
ORDER BY 1; -- 57(5명 중복)

SELECT FOUND_ROWS();


-- 재난 지원금을 지원하려고 한다.
-- 대상은 50번 부서원이고  manager 직종으로 한정하여 조회해 본다
SELECT employee_id, first_name, department_id, job_id
FROM emp_dept_50
INTERSECT
SELECT employee_id, first_name, department_id, job_id
FROM emp_job_man;

-- 재난 지원금을 지원하려고 한다.
-- 대상은 50번 부서원인데 이중에서   manager 직종은 제외 조회해 본다
SELECT employee_id, first_name, department_id, job_id
FROM emp_dept_50
except
SELECT employee_id, first_name, department_id, job_id
FROM emp_job_man;

SELECT employee_id, first_name, department_id, job_id
FROM emp_job_man
except
SELECT employee_id, first_name, department_id, job_id
FROM emp_dept_50;


-- 집합 연산자 -  2개 테이블의 행 갯수 합병-행갯수 변화
-- join - 2개 테이블 컬럼 갯수 합병 - 1개 레코드 열갯수 변화
-- SUBQUERY , JOIN QUIERY

-- 사원명 부서명 조회. 2개 테이블 동일값 컬럼 존재
SELECT FIRST_NAME, department_id FROM employees;

SELECT department_name , department_id FROM departments;


SELECT FIRST_NAME, department_name 
FROM employees inner join departments 
ON employees.department_id=departments.department_id
;

SELECT FIRST_NAME, department_name 
FROM employees join departments 
ON employees.department_id=departments.department_id
;

SELECT e.FIRST_NAME, e.department_id, d.department_id, d.department_name 
FROM employees e join departments d 
ON e.department_id=d.department_id
;
/*
select
from a join b on a.컬럼=b.컬럼

*/
/*
SELECT FIRST_NAME, department_name 
FROM employees cross join departments 
;
*/


-- jobs 테이블 - JOB_ID--> IT_PROG,, JOB_TITLE--> ""
-- employees job_id references jobs(job_id)

-- 사원이름, 직종이름, 급여 조회
select first_name, job_title, salary
FROM employees e join jobs j ON e.job_id = j.job_id;


-- 사원이름, 직종이름, 부서이름 조회
-- 단, 급여 10000 이상인 사원만 대상
SELECT first_name, job_title,	 department_name, salary
FROM employees e 
JOIN jobs j ON e.job_id=j.job_id
JOIN departments d ON e.department_id = d.department_id
WHERE salary >= 10000;

-- subquery 중첩 =join
-- seattle 도시 근무 사원의 사원명, 부서명, 도시명 조회
-- 
SELECT first_name, department_name, city
from locations l 
join departments d ON d.location_id = l.location_id
JOIN employees e ON e.department_id= d.department_id
WHERE city='seattle';

 -- db 표준 문법 join(ansi join)
SELECT a, b
FROM atbl join btbl ON a=b;

-- db 종속
SELECT a, b
FROM atbl , btbl WHERE  a=b;
 
-- 양쪽 테이블 조건 만족하는 데이터들만 조인 가져온다
 
select first_name, department_name
FROM employees e join departments d ON e.department_id = d.department_id;

--                                         NULL                NULL 부서이름 
SELECT first_name
FROM employees
WHERE depARTMENT_ID IS NULL;

-- 조건 범위 외부에 있어도 조인 \
-- 부서 배정되지 않는 사원도 포함 조인
select first_name, department_name
FROM employees e LEFT OUTER join departments d ON e.department_id = d.department_id;


--  
SELECT * FROM departments;


-- 부서명 사원명 조회. 단, 1명의 사원도 소속되지 않은 부서도 포함 조인
select first_name, department_name
FROM employees e RIGHT OUTER join departments d ON e.department_id = d.department_id;


-- 부서명 사원명 조회. 단, 1명의 사원도 소속되지 않은 부서도, 소속 부서 없는 사원도 포함 조인

select first_name, department_name
FROM employees e LEFT OUTER join departments d ON e.department_id = d.department_id
UNION
select first_name, department_name
FROM employees e RIGHT OUTER join departments d ON e.department_id = d.department_id;


-- 
SELECT e.* , DEPARTMENT_NAME
FROM employees e INNER join departments d ON e.department_id = d.department_id;


-- subqyery와 join은 같은 결과 쿼리

SELECT
FROM (SELECT - inline VIEW)

- seattle 에서 근무하는 사원의 이름 부서명  국가 대륙 조회
DESC countries;
DESC regions;

SELECT inform.emp, depart, coun, re
FROM (
	SELECT first_name emp, department_name depart, country_name coun , region_name re
	FROM employees e
	JOIN departments d ON e.department_id = d.department_id
	JOIN locations l ON d.location_id=l.location_id 
	JOIN countries c ON l.country_id = c.country_id
	JOIN regions r ON c.region_id= r.region_id
	WHERE l.city='seattle'
) inform
;

-- 자체조인(self join)
-- 조인 대상 테이블이 자신 테이블

DESC employees;


SELECT employee_ID, MANAGER_ID FROM employees;

-- 각 사원의 정보 중에서 상사 사번 컬럼 포함

-- 내 상사의 이름, 급여 조회

SELECT MANAGER_ID FROM employees WHERE EMPLOYEE_ID=150;-- 145

SELECT FIRST_NAME, SALARY, EMPLOYEE_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=145;

SELECT FIRST_NAME, SALARY, EMPLOYEE_ID FROM employees 
WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID FROM employees );


-INNER JOIN
SELECT FIRST_NAME , DEPARTMENT_NAME
FROM employees INNER join departments ON eMPLOYEES.department_id = dEPARTMENTS.department_id;

-- SELF JOIN
SELECT ME.EMPLOYEE_ID 내사번, ME.FIRST_NAME 내이름 , 
ME.MANAGER_ID 상사사번, MAN.employee_id 상사사번2, 
MAN.FIRST_NAME 상사이름 
FROM employees ME JOIN employees MAN
ON ME.MANAGER_ID = MAN.employee_id;
 
-- 내사번, 내이름, 상사의사번, 상사의이름 조회하되 상사가 없는 사원 포함 조회
SELECT * FROM employees WHERE MANAGER_ID IS NULL;

SELECT ME.EMPLOYEE_ID 내사번, ME.FIRST_NAME 내이름 , 
ME.MANAGER_ID 상사사번, MAN.employee_id 상사사번2, 
IFNULL(MAN.FIRST_NAME, 'BOSS') 상사이름 
FROM employees ME LEFT OUTER JOIN employees MAN
ON ME.MANAGER_ID = MAN.employee_id;




-- 부하직원 없는 상사 조회
SELECT ME.EMPLOYEE_ID 내사번, ME.FIRST_NAME 내이름 , 
ME.MANAGER_ID 상사사번, MAN.employee_id 상사사번2, 
MAN.FIRST_NAME 상사이름 
FROM employees ME RIGHT OUTER JOIN employees MAN
ON ME.MANAGER_ID = MAN.employee_id;

- INNER JOIN + OUTER JOIN + SELF JOIN


-- 11장 함수
-- 집계함수 - COUNT MA MIN SUM AVG -> 여러개 레코드 모아서 1개 결과 리턴

-- 조건함수- CASE 함수

/*
CASE
WHEN 조건식1 THEN TRUE일때결과값1
WHEN 조건식2 THEN TRUE일때결과값2
.....
ELSE 위조건식모두 불일치하는 경우결과값N
END ALIAS명

*/

-- IFNULL(컬럼명, NULL인경우대체값)

-- NULLIF( 값1, 값2)

-- 리턴값 1개 =함수이름(매개변수,,,)
