-- 11장 함수 19장 트랜잭션
-- 함수 - 주어진 언어내부 연산자 제공되지 않은 기능 구현
-- 결과 1개= 이름(매개변수)
-- maria db 내장 함수
-- 집계함수(group) --> 여러개 레코드 모아서 1개
-- scalar 함수 --> 1개 레코드 결과 1개
-- round= 반올림
SELECT 1234.5678, ROUND (1234.5678), ROUND(1234.5678 ,1), ROUND(1234.5678,2);

SELECT * FROM employees;

-- 문자
SELECT phone_number, REPLACE(phone_number,'.','-') FROM employees;

-- 성 -last_name, 이름 -first_name from employees;
SELECT CONCAT("성 -",last_name," 이름 -",first_name) FROM employees;

-- CONCAT("성 -",last_name," 이름 -",first_name)

-- java -char(' ')/string(" ")
-- database -char/varchar -문자열표현(' ')
-- mariadb -char /varchar 256바이트(한글 3바이트) -문자열표현('',"")
-- mariadb -text 65536 문자 -문자열표현(''."")

--숫자함수
-- 숫자형 데이터 타입
-- 정수 tinyint(1) smallint(2) int(4) long(8)
-- 실수 float(4) double(8)
-- 사용자 구성 decimal(10,0),decimal(8,2)
-- round 정수는 소수점 -정수는 정수부분 1,10,100 자리
-- 평균급여

SELECT AVG(salary),ROUND(AVG(salary)),TRUNCATE(AVG(salary),0) FROM employees;
SELECT 123.5678,ROUND(123.5678,0),ROUND(123.5678,-1),ROUND(123.5678,-2);

-- + - * / % (나머지)
-- mod(나머지) 3- 3의 배수인지 7- 7의 배수인지

SELECT 1234,MOD(1234,3),MOD(1234,7);
SELECT * FROM employees;

-- employees 짝수사번의 사번, 이름 조회
SELECT first_name,employee_id 
FROM employees 
WHERE MOD(employee_id,2)=0;

SELECT first_name,employee_id,
case
when MOD(employee_id,2)=0 then '짝수사번'
ELSE '홀수사번'
END "사번의 성격"
FROM employees;


-- 문자열
-- 256 자리 - char/ varchar /
-- 65536 -text
CREATE TABLE productfunc(
NAME CHAR(100),
price DECIMAL(10,2),
detail TEXT,
imagefile VARCHAR(100));

SELECT * FROM productfunc;

INSERT INTO productfunc VALUES('computer',1000.99,'......empdb..','com.jpg');

SELECT ASCII('A'),CHAR(65);

-- length -> 바이트 수 1 byte= 8 bit    bit_length= bit 길이
SELECT "ABCDEF", "가나다라마바",
CHAR_LENGTH("ABCDEF"),
CHAR_LENGTH( "가나다라마바"),
BIT_LENGTH("ABCDEF"),
 BIT_LENGTH("가나다라마바"),
 LENGTH("ABCDEF"), LENGTH("가나다라마바");

-- 문자 찾기(날짜도 문자열함수 사용)
SELECT ELT(2,'일여','둘','셋'); -- 자바 index 번호 0 시작 .DB 1
SELECT FIELD('일이','일이','둘','셋');
SELECT FIND_IN_SET('일이','일이,삼사,오육');
SELECT INSTR('일이삼사오육','삼');
SELECT LOCATE('삼','일이삼사오육');
SELECT SUBSTRING('김상형의 sql정복',5,3);
SELECT SUBSTR('김상형의 sql정복',5,3);
SELECT hire_date, FROM emplooyees;
SELECT NOW(); -- 날짜시간타입 형식 확인

SELECT hire_Date 입사시각,
SUBSTR(hire_date,1,4) 입사년도,
SUBSTR(hire_date,6,2) 입사월 FROM employees;

SELECT SUBSTR(hire_date,6,2) 입사월, COUNT(*) 입사자수 
FROM employees GROUP BY SUBSTR(hire_date,6,2);

-- 클라이언트 암호 입력 -> db 테이블 저장

SET @pw = "abc가나다123";
SELECT @pw, INSERT(@pw, 2, 4, "****");
SELECT repeat("*", CHAR_LENGTH(@pw));

-- @pw 변수의 모든값을 * 조회

SELECT INSERT( @pw, 1, CHAR_LENGTH(@PW), "*");
SELECT INSERT( @pw, 1, CHAR_LENGTH(@pw), REPEAT("*", CHAR_LENGTH(@pw) ));
SELECT INSERT( @pw, 2, CHAR_LENGTH(@pw) - 1, REPEAT("*", CHAR_LENGTH(@pw) - 1 ));


SELECT "ABCDEF",LEFT("ABCDEF",3),RIGHT("ABCDEF",3);
SELECT "maria database",UPPER("maria database"),lowER("MARIA DATABNASE");

-- 자바 키보드 입력 "MARIA".TOUPPERCASE() -- DB UPPer('maria')

-- pad -다른문자열 채운다
SELECT 'abc',lpad('abc',10,"#"),RPAD('abc',10,"#");
-- trim -문자열 잘라낸다.
SELECT 'abc',lpad('abc',10," "),RPAD('abc',10," ");

SELECT first_name,lpad(first_name,20,"-") FROM employees;

SET @pw="    김상형의 sql 정복     ";
SELECT CHAR_LENGTH(@pw), CHAR_LENGTH(LTRIM(@pw)),CHAR_LENGTH(rTRIM(@pw));

SET @pw="ㅋㅋㅋ웃겨요ㅋㅋㅋㅋ";
SELECT TRIM(LEADING 'ㅋ' FROM @pw), TRIM(trailING 'ㅋ' FROM @pw),TRIM(BOTH 'ㅋ' FROM @pw);

-- create table/ alter table
DESC emp_copy;

SELECT MIN(employee_id),MAX(employee_id) FROM employees;
INSERT INTO emp_copy VALUES (300,'길동','최',10000,NOW(),200);
INSERT INTO emp_copy VALUES ('301','길동','최',10000,NOW(),200);
INSERT INTO emp_copy VALUES (302,'길동','최',10000,current_date(),200);
INSERT INTO emp_copy VALUES (302,'길동','최',10000,'2022-12-28 00:00:00',200);
INSERT INTO emp_copy VALUES (303,'길동','최',10000,DATE_SUB(now(),INTERVAL 4 MONTH),200);
INSERT INTO emp_copy VALUES (304,'길동','최',10000,'20221212',200);
INSERT INTO emp_copy VALUES (305,'길동','최',10000,20221212,200);
SELECT * FROM emp_copy ORDER BY employee_id DESC;

SELECT 100+200;
SELECT '100' +'200'; -- concat다름
SELECT CONCAT('100','200');
-- 명시적 형변환
SELECT 123.444,ROUND(123.444),TRUNCATE(123.444,0);

-- cast,convert,format
SELECT AVG(salary), CAST(AVG(salary) AS SIGNED integer),
CONVERT (AVG(salary),SIGNED INTEGER),
FORMAT(AVG(salary),0) FROM employees;

-- ifnull(컬럼명, 컬럼null 대체값) --null 연산식 null 0 
-- NULLIF(값 1,값2) is null;
-- if(t/f,t,f)
SELECT if (20>10,"크다","작거나 같다");

-- 사원들 commisssion_pct null 사원들, 그렇지 않은 사원들
-- 이름       보너스 유무
-- kelly			못받는다
select first_name 이름,if(commission_pct IS NULL,"못 받는다","받는다")보너스유무 
FROM employees; 

-- 급여정보 연말보너스 지급
-- 20000 이상이면 5000 증가
-- 15000 이상 20000 미만 10000증가
-- 10000 이상 15000 미만 20000증가
-- 나머지 30000 증가

SELECT first_name 이름, salary 급여, 
case 
when salary >= 20000 then salary +5000
when salary >= 15000 AND salary < 20000 then salary+10000
when salary >= 10000 then salary+20000
ELSE salary+30000
END 연말보너스
FROM employees;

-- 2002년 이전까지 입사자 30000
-- 2005년 이전까지 입사자 20000
-- 나머지 10000
-- 입사년도 조회
SELECT first_name,substr(hire_date,1,4) 년도, salary 급여,
case SUBSTR(hire_date,1,4)
when '2001' then salary+ 30000
when '2002' then salary+ 30000 
when '2003' then salary+ 20000 
when '2004' then salary+ 20000 
when '2005' then salary+ 20000 
ELSE salary+10000
END 연말보너스
FROM employees;

SELECT first_name,substr(hire_date,1,4) 년도, salary 급여,
case 
when SUBSTR(hire_date,1,4) IN ('2001','2002') then salary+ 30000
when SUBSTR(hire_date,1,4) IN ('2003','2004','2005') then salary+ 20000 
ELSE salary+10000
END 연말보너스
FROM employees;

-- maria db 
-- 날짜 함수
-- sysdate는 1/1000초 데이터도 포함
SELECT CURDATE(),CURRENT_DATE, CURTIME(),NOW(), SYSDATE();

-- yyyy-mm-dd HH:mm:ss == 자바
SELECT NOW(),DATE_FORMAT(NOW(),'%y/%m/%d');
SELECT NOW(),DATE_FORMAT(NOW(),'%Y/%M/%D');
SELECT NOW(),DATE_FORMAT(NOW(),'%Y/%c/%e');

SELECT NOW(),date_format(NOW(),'%y/%m/%d');

/*
%Y,%y -4/2자리 년도
%m,%M,%c- 2자리/ 영문월이름,1,2자리
%d,%e - 2/1,2자리 일
%w- 영문요일
%a- 영문 3글자요일
%H,%h- 24/12 시간
%i- 분
%s- 초
*/
-- 0-49 2000년도,50-99 -> 1900년도

-- 2006년도 입사자 급여조회
SELECT hire_date, salary FROM employees
WHERE hire_Date >= '2006-01-01 00:00:00'
AND hire_date < '2007-01-01 00:00:00';

-- 연도 추출 함수 2006년
SELECT YEAR(NOW()),MONTH(NOW()),DAY(NOW()),HOUR(NOW()), MINUTE(NOW()), SECOND(NOW());
select hire_date,salary from employees where hire_date like '2006%';
select hire_date,salary from employees where  substr(hire_date,1,4)= '2006';
SELECT hire_Date,salary FROM employees WHERE INSTR(hire_Date,'2006')=1;
SELECT hire_Date,salary FROM employees WHERE date_format(hire_Date,'%Y')='2006';

SELECT SUBSTR(hire_Date,1,4),DATE_FORMAT(hire_date,'%Y'),YEAR(hire_date),salary FROM employees;

-- 월 추출 06월
select hire_date,salary from employees where hire_date like '_____06%'; -- 11
select hire_date,salary from employees where  substr(hire_date,6,2)= '06'; -- 11 
SELECT hire_Date,salary FROM employees WHERE INSTR(right(hire_Date,CHAR_LENGTH(hire_date)-5),'06')=1; -- 10
SELECT hire_Date,salary FROM employees WHERE date_format(hire_Date,'%m')='06';
SELECT hire_date,salary FROM employees WHERE month(hire_date)='06';

-- 2006년 이후 입사자 2006,2007,2008
SELECT hire_date, salary FROM employees
WHERE hire_Date >= '2006-01-01 00:00:00';
select hire_date,salary from employees where  substr(hire_date,1,4)>= '2006'
ORDER BY hire_date;
SELECT hire_Date,salary FROM employees WHERE date_format(hire_Date,'%Y')>='2006'
ORDER BY hire_date;
SELECT hire_date,salary FROM employees WHERE YEAR(hire_date)>='2006'
ORDER BY hire_date;
-- 0 월 2 수 6 일
SELECT WEEKDAY(NOW());


SELECT upper(first_name) 사원이름,
CONCAT(
case WEEKDAY(hire_date)
when 0 then '월'
when 1 then '화'
when 2 then '수'
when 3 then '목'
when 4 then '금'
ELSE '주말'
END, '요일') 입사요일
from employees;

-- 두 날짜 사이의 계산
SELECT CURDATE() 오늘날짜,
SUBDATE(CURDATE(),INTERVAL 1 DAY) 어제날짜,
ADDDATE(CURDATE(), INTERVAL 1 DAY) 내일날짜,
ADDDATE(CURDATE(), INTERVAL 1 MONTH) 한달후날짜, 
adddate(CURDATE(), INTERVAL 1  YEAR) 1년후날짜;

-- now() hire_date --> 입사한지 얼마나 경과일수 계산
SELECT DATEDIFF(NOW(),hire_date) 경과일수,
truncate(DATEDIFF(NOW(),hire_date)/7,0) 경과주수,
truncate(DATEDIFF(NOW(),hire_date)/365,0) 경과년수,
PERIOD_DIFF(curdate(),DATE_FORMAT(hire_date, "%Y%m")) 경과개월수
FROM employees;


--트랜잭션 -여러개 작업 논리 결함
-- 여러개 sql 실행(1개 덩어리) - 계좌이체 1개 실행
-- 마리아 db 변수
 
SHOW variables LIKE '%auto';
SET autocommit=FALSE;
SHOW variables LIKE '%auto';
