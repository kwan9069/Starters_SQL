USE empdb;

-- 1. 80번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 부서id, 급여를 조회하시오.
-- 27개
SHOW TABLES;
employees  

SELECT first_name, department_id, salary, 
(SELECT AVG(salary) FROM employees WHERE department_id=80)
FROM employees
WHERE salary >  (SELECT AVG(salary) FROM employees WHERE department_id=80); 


2. 'South San Francisco'에 근무하는 직원의 최소급여보다 급여를 많이 받으면서 
50 번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 급여, 부서명, 
부서id를 조회하시오.-- 69

SELECT first_name, salary, department_name, e.department_id
FROM employees e join departments d ON e.department_id=d.department_id
WHERE salary > (SELECT MIN(salary)
						from locations l
						JOIN departments d ON l.location_id=d.location_id
						JOIN employees e ON d.department_id=e.department_id
						WHERE city="South San Francisco")

AND salary > (SELECT AVG(salary) FROM employees WHERE department_id=50);

SELECT MIN(salary)
from locations l
JOIN departments d ON l.location_id=d.location_id
JOIN employees e ON d.department_id=e.department_id
WHERE city="South San Francisco";

locations - location_id, city 
departments - department_id, ....location_id
employees - salary, department_id 


3-1.각 직급별(job_title) 인원수를 조회하되 사용되지 않은 직급이 있다면(사용되지 않는 직급은 없다) 
해당 직급도 출력결과에 포함시키시오. 

jobs - job_id(IT) job_title
employees - job_id(IT_PROG)

SELECT JOB_TITLE, COUNT(*)
FROM jobs J LEFT OUTER JOIN employees E ON E.JOB_ID=J.JOB_ID
GROUP BY JOB_TITLE; -- 19


3-2. 직급별 인원수가 10명 이상인 직급만 출력결과에 포함시키시오.-- 3
SELECT JOB_TITLE, COUNT(*)
FROM jobs J LEFT OUTER JOIN employees E ON E.JOB_ID=J.JOB_ID
GROUP BY JOB_TITLE
HAVING COUNT(*) >= 10;



4. 각 부서별 최대급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.

SELECT FIRST_NAME, DEPARTMENT_NAME, SALARY
FROM employees E JOIN departments D ON D.department_id=E.DEPartment_id
WHERE (e.department_id, salary) = any 
( SELECT department_id , MAX(salary) FROM employees GROUP BY department_id );


5. 직원의 이름, 부서id, 급여를 조회하시오. 그리고 직원이 속한 해당 부서의 
최소급여를 마지막에 포함시켜 출력 하시오.

SELECT FIRST_NAME "직원 이름" , DEPARTMENT_id 부서코드 , SALARY 내급여,
 (SELECT min(salary) FROM employees WHERE e.department_id = department_id) 
 "내부서의 최소급여"
FROM employees e;



6. 월별 입사자 수를 조회하되, 입사자 수가 10명 이상인 월만 출력하시오.
SELECT hire_month, COUNT(hire_month)
FROM  (SELECT 
case 
when hire_date LIKE '_____01%' then '01'
when hire_date LIKE '_____02%' then '02'
when hire_date LIKE '_____03%' then '03'
when hire_date LIKE '_____04%' then '04'
when hire_date LIKE '_____05%' then '05'
when hire_date LIKE '_____06%' then '06'
when hire_date LIKE '_____07%' then '07'
when hire_date LIKE '_____08%' then '08'
when hire_date LIKE '_____09%' then '09'
when hire_date LIKE '_____10%' then '10'
when hire_date LIKE '_____11%' then '11'
when hire_date LIKE '_____12%' then '12'
END hire_month FROM employees) imsi
GROUP BY hire_month
ORDER BY 1;

7. 자신의 관리자(상사)보다 많은 급여를 받는 직원의 이름과 급여를 조회하시오.-- 2
SELECT e1.first_name 직원이름 , e1.salary 직원급여, e2.first_name 상사이름, e2.salary 상사급여
FROM employees e1 JOIN employees e2 ON e1.manager_id=e2.employee_id
WHERE e1.salary > e2.salary;


8. 'Southlake'에서 근무하는 직원의 이름, 급여, 직책(job_title)을 조회하시오. -- 5
SELECT first_name, salary, job_title
FROM employees e 
join departments d ON d.department_id=e.department_id
join locations l ON d.location_id=l.location_id
join jobs j ON e.job_id = j.job_id
WHERE city="Southlake";


9. 국가이름 근무 인원수를 조회하시오. 단, 인원수가 3명 이상인 국가정보만 출력되어야함.-- 2
SELECT country_name, COUNT(*)
FROM employees E 
JOIN departments D ON d.department_id=e.department_id
JOIN locations L ON d.location_id=l.location_id
JOIN countries C ON L.country_id= C.country_id
GROUP BY country_name
HAVING COUNT(*) >= 3;



10. 직원의 폰번호, 이메일과 상사의 폰번호, 이메일을 조회하시오. 
단, 상사가 없는 직원은 '<관리자 없음>'이 출력되도록 해야 한다.

SELECT e1.PHONE_NUMBER 직원폰번호 , e1.EMAIL 직원이메일, 
IFNULL(e2.PHONE_NUMBER, '<관리자 없음>') 상사폰번호, 
IFNULL(e2.EMAIL , '<관리자 없음>') 상사이메일
FROM employees e1 LEFT OUTER JOIN employees e2 ON e1.manager_id=e2.employee_id;




11. 각 부서 이름별로 최대급여와 최소급여를 조회하시오. 
단, 최대/최소급여가 동일한 부서는 출력결과에서 제외시킨다.(1사원) -- 8

SELECT DEPARTMENT_NAME, MAX(SALARY), MIN(SALARY)
FROM departments D JOIN employees E ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
HAVING MAX(SALARY) != MIN(SALARY);


12. 부서별, 직급별, 평균급여를 조회하시오. 
   단, 평균급여가 50번부서의 평균보다 많은 부서만 출력되어야 합니다.

SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY)
FROM employees
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM employees WHERE DEPARTMENT_ID=50); 
