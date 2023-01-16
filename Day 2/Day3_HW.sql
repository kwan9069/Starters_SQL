SELECT * FROM jobs;
SELECT * FROM employees;
-- 1.
SELECT first_name,department_ID,SALARY FROM employees 
WHERE SALARY >
(SELECT avg(SALARY) FROM employees e WHERE e.department_id=80);

-- 2. 미해결
SELECT * FROM departments;
SELECT * FROM locations;
SELECT first_name,salary,d.department_name,d.department_id 
FROM employees e 
JOIN departments d ON e.department_id=d.department_id
JOIN locations l ON l.location_id=d.location_id
WHERE salary > all
(MIN(salary) FROM employees JOIN departments ON d.department_id=e.department_id JOIN locations l ON l.location_id=d.location_id WHERE city="South San Francisco" and
AVG(salary) FROM employees join departments ON d.department_id=e.department_id WHERE department_id=50);

-- 3-1.
SELECT job_title,COUNT(case when j.job_id=e.job_id then 1 END)
FROM employees e JOIN jobs j
ON e.job_id=j.job_id GROUP BY e.job_id;

-- 3-2. 
SELECT job_title, COUNT(case when j.job_id=e.job_id then 1 END)
FROM employees e   JOIN jobs j
ON e.job_id=j.job_id GROUP BY e.job_id HAVING COUNT(case when j.job_id=e.job_id then 1 END)>= 10;


-- 4. 
SELECT first_name,department_name, max(salary) FROM employees e JOIN departments d
ON e.department_id=d.department_id group BY e.department_id;

-- 5. 미해결
SELECT first_name, department_id, salary, 
(SELECT MIN(salary)  FROM employees WHERE e.department_id=department_id) 최소급여
FROM employees e;


SELECT * FROM locations;
SELECT * FROM employees;

-- 6.
SELECT month(hire_date) 월별  ,COUNT(*) from employees GROUP BY 월별  HAVING COUNT(*)>=10;
SELECT MONTH(hire_date) 월별, COUNT(*)입사자 FROM employees GROUP BY 월별 HAVING 입사자>=10;


SELECT * FROM jobs;

SELECT * FROM departments;
SELECT * FROM employees WHERE first_name="gerald" OR first_name="eleni"; -- 11000,10500
SELECT * FROM employees WHERE employee_id=100;
-- 7 . 미해결
SELECT e.first_name,man.salary FROM employees e JOIN employees man ON man.manager_id=e.employee_id WHERE man.manager_id=e.employee_id AND man.salary<e.salary;

-- 8.
SELECT first_name, salary, job_title
 FROM jobs j
 join employees e ON e.job_id= j.job_id
 JOIN departments d ON e.department_id=d.department_id
 JOIN locations l ON d.location_id=l.location_id
 WHERE l.city= 'Southlake';
 
-- 9.
SELECT country_id,COUNT(country_id) c FROM locations l
GROUP BY country_id HAVING c>=3;


-- 10.
SELECT e.phone_number 직원의폰번호,e.email 직원의이메일,ifnull(man.phone_number,'관리자 없음') 상사의폰번호,ifnull(man.email,'관리자 없음') 상사의이메일 FROM employees e left outer JOIN employees man ON e.employee_id=man.manager_id; 

-- 11.
SELECT department_name,MAX(salary),MIN(salary) FROM employees e JOIN departments d ON e.department_id=d.department_id GROUP BY department_name HAVING (MAX(salary) != MIN(salary));

SELECT * FROM jobs;
SELECT * FROM employees;

-- 12.
SELECT job_title,(department_id,AVG(salary) 
FROM employees GROUP BY department_id having avg(salary) > (SELECT AVG(salary) FROM employees GROUP BY department_id having department_id=50))
FROM employees e JOIN jobs j ON e.job_id=j.job_id GROUP BY job_title HAVING AVG(salary) > (SELECT AVG(salary) FROM employees GROUP BY department_id having department_id=50);

SELECT * FROM member;

CREATE TABLE deletedmember(SELECT * FROM member);

SELECT * FROM deletedmember;

DELETE FROM deletedmember;

INSERT INTO member VALUES ('deletetest','deletetest','이상형','010234232','lee@b.com','오름',SUBDATE(NOW());