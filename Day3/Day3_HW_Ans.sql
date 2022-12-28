SELECT * FROM employees;
SHOW TABLES;

-- 1.
SELECT first_name,department_id,salary,
(SELECT AVG(salary) FROM employees WHERE department_id=80)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id=80);

-- 2.
SELECT first_name, salary, d.department_name, e.department_id
FROM employees e join departments d ON e.department_id=d.department_id
WHERE salary >  (SELECT MIN(salary)
				from locations l
				JOIN departments d ON l.location_id=d.location_id
				JOIN employees e ON d.department_id=e.department_id
				WHERE city= "south san francisco")
AND salary > (SELECT AVG(salary) FROM employees WHERE department_id=50);

SELECT first_name,d.department_id, d.location_id, city
from locations l
JOIN departments d ON l.location_id=d.location_id
JOIN employees e ON d.department_id=e.department_id
WHERE city= "south san francisco";
-- locations - city, location_id
-- departemnts - department_id,location_id
-- employees - salary


-- 3-1.
-- jobs job_id(IT) job_title
-- employees - job_id(it_prog)
SELECT job_title,COUNT(*) 
FROM jobs j JOIN employees e ON e.job_id=j.job_id
GROUP BY job_title;

-- 3-2.
SELECT job_title,COUNT(*) 
FROM jobs j JOIN employees e ON e.job_id=j.job_id
GROUP BY job_title HAVING COUNT(*) > 10;

-- 4.
SELECT first_name, department_name, salary
FROM employees E JOIN departments d ON d.department_id=e.department_id
WHERE (e.department_id,salary)= any (SELECT department_id,MAX(salary) FROM employees GROUP BY department_id); 

-- 5.
SELECT first_name "직원 이름", department_id 부서코드, salary 내급여,  
(SELECT Min(salary) FROM employees WHERE e.department_id=department_id)
"내부서의 최소급여"
FROM employees e;
 
 
 -- 6.
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
 
 -- 7.
 SELECT e1.first_name 직원이름, e1.salary 직원급여, e2.first_name 상사이름, e2.salary 상사급여
FROM employees e1 JOIN employees e2 ON e1.manager_id=e2.employee_id 
WHERE e1.salary>e2.salary;

-- 8.
SELECT first_name,salary,job_title
FROM employees e 
JOIN departments d ON d.department_id=e.department_id
JOIN locations l ON d.location_id=l.location_id
JOIN jobs j ON e.job_id=j.job_id
WHERE city= "Southlake";

-- 9.
SELECT country_name,COUNT(*)  FROM employees e
JOIN departments d on d.department_id=e.department_id
JOIN locations l on d.location_id=l.location_id
JOIN countries c on l.country_id=c.country_id
GROUP BY country_name HAVING COUNT(*)>=3;

-- 10.
SELECT e1.phone_number 직원폰번호, e1.email 직원이메일, ifnull(e2.phone_number,"관리자 없음") 상사폰번호, ifnull(e2.email,'관리자 없음') 상사이메일
FROM employees e1 left outer JOIN employees e2 ON e1.manager_id=e2.employee_id;

-- 11.
SELECT department_name,MAX(salary),MIN(salary)
FROM departments d JOIN employees e ON d.department_id=e.department_id
GROUP BY department_name
HAVING MAX(salary) != MIN(salary);

-- 12.
SELECT department_id, job_id, AVG(salary)
FROM employees
GROUP BY department_id, job_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees WHERE department_id = 50);

