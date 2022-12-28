-- 숫자함수

-- 숫자형데이터타입
-- 정수 tinyint(1)  smallint(2) int(4) long(8) 상품코드 
-- 실수 float(4) double(8) 
-- 사용자 구성 decimal(10, 0), decimal(8, 2) 
-- round 

-- 평귭급여, 반올림, 소수점이하절삭
SELECT AVG(salary), ROUND( AVG(salary)) , TRUNCATE (AVG(salary) , 0)  FROM employees;
SELECT 123.5678, ROUND( 123.5678 , 0) , ROUND( 123.5678, -1 ), ROUND( 123.5678, -2 ) ;
-- + - * / %(나머지연산자)
-- MOD
SELECT 1234, MOD(1234, 3) , MOD(1234, 7) ;

-- MOD 사용하여 employees 짝수사번의 사번, 이름 조회
-- 2로 나누어 나머지 0
SELECT EMPLOYEE_ID, FIRST_NAME FROM employees
WHERE MOD(EMPLOYEE_ID, 2) = 0;

100 짝수사번
101 홀수사번

SELECT EMPLOYEE_ID, FIRST_NAME, 
CASE
WHEN MOD(EMPLOYEE_ID, 2)=0 THEN '짝수사번'
ELSE '홀수사번'
END "사번의 성격"
 FROM employees;


-- 256 자리 - CHAR / VARCHAR / 
-- 65536 - TEXT

CREATE TABLE productFUNC(
NAME CHAR(100),
PRICE DECIMAL(10, 2),
DETAIL TEXT,
IMAGEFILE VARCHAR(100));


INSERT INTO productfunc VALUES('COMPUTER', 1000.99, '........', 'COM.JPG');

SELECT ASCII('A'), CHAR(65);

-- LENGTH()->BYTE ( 1BYTE = 8BIT )
SELECT "ABCDEF", "가나다라마바", CHAR_LENGTH("ABCDEF"),  BIT_LENGTH("ABCDEF") ,  LENGTH("ABCDEF"),
 CHAR_LENGTH("가나다라마바"), BIT_LENGTH("가나다라마바"),  LENGTH("가나다라마바");

-- 문자 찾기(날짜도 문자열함수 사용)
-- 오라클 + MYSQL ==> 함수+MARIADB

SELECT ELT(2, '일이', '둘', '셋'); -- 자바 INDEX번호 0 시작 . DB 1
SELECT FIELD('일이','일이', '둘', '셋');
SELECT FIND_IN_SET('일이','일이,삼사,오육');
SELECT INSTR('일이삼사오육', '삼' );
SELECT LOCATE('삼', '일이삼사오육');
SELECT SUBSTRING('김상형의 SQL정복' ,5, 3);
SELECT SUBSTR('김상형의 SQL정복' ,5, 3);
SELECT NOW(); -- 날짜시간타입형식 확인

SELECT HIRE_DATE 입사시각 , SUBSTR(HIRE_DATE, 1, 4) 입사년도 , SUBSTR(HIRE_date, 6, 2) 입사월 FROM employees;


-- 월별 입사자 수를 조회하되, 입사자 수가 10명 이상인 월만 출력하시오.
SELECT SUBSTR(HIRE_date, 6, 2) 입사월 , COUNT(*) 입사자수
FROM employees
GROUP BY SUBSTR(HIRE_date, 6, 2);



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


-- 클라이언트 암호 입력 -->db 테이블 저장
SET @pw = "abc가나다123567575757546SADSA";
SELECT @pw,  INSERT(@pw, 2, 4, "*");
SELECT repeat("*", CHAR_LENGTH(@pw) );

-- @pw 변수의 모든 값을 * 조회

SELECT @pw, INSERT(@pw, 2, CHAR_LENGTH(@PW)-1, REPEAT("*" ,CHAR_LENGTH(@PW) -1)) ;

-- 
SELECT "ABCDEF" , LEFT("ABCDEF", 3) , RIGHT("ABCDEF", 3);

--initcap 없음(첫문자대문자)
SELECT "mArIa DATABase", UPPER("mArIa DATABase"), LOWER("mArIa DATABase");
-- 자바 키보드 입력 "Maria".toUpperCase()  --- db upper('mArIa')

-- pad- 다른문자열 채운다
SELECT 'abc', LPAD('abc', 10, "#") , rPAD('abc', 10, "#");

SELECT 'abc', LPAD('abc', 10, " ") , rPAD('abc', 10, " ");

SELECT first_name, LPAD(first_name, 20, "-")  FROM employees;
DESC emp_copy;

-- trim- 문자열 잘라낸다
SET @pw = "    김상형의 sql 정복    ";
SELECT CHAR_LENGTH(@pw) , CHAR_LENGTH(LTRIM(@pw)), CHAR_LENGTH(rtrim(@pw));

SET @pw = "ㅋㅋㅋㅋ웃겨요ㅋㅋㅋ";
SELECT TRIM(LEADING 'ㅋ' FROM @pw), TRIM(trailing 'ㅋ' FROM @pw), TRIM(both 'ㅋ' FROM @pw);


-- create table / alter table 
-- 문자 char / varchar / text
-- 숫자 int double decimal(10, 0)
-- 날짜 date , time, datetime


-- 날짜 문자 숫자 입력
-- 날짜<--> 문자자동형변환<--->숫자
-- emp_copy  복사 - 제약조건복사안됨(not null 제외)

SELECT MIN(employee_id), max(employee_id) FROM employees;

-- hire_date - DATETIME 타입

INSERT INTO emp_copy VALUES(300, '길동', '최',  10000, NOW(), 200);
INSERT INTO emp_copy VALUES('301', '길동', '최',  10000, NOW(), 200);
INSERT INTO emp_copy VALUES(302, '신입', '최',  10000, CURRENT_date, 200);
INSERT INTO emp_copy VALUES(303, '대리', '김',  10000, '2019-12-28 00:00:00', 200);
INSERT INTO emp_copy VALUES(304, '과장', '김',  10000, date_sub(NOW() , INTERVAL 4 MONTH), 200);
INSERT INTO emp_copy VALUES(305, '대리', '김',  10000, '20221212', 200);
INSERT INTO emp_copy VALUES(306, '대리', '박',  10000, 20221212, 200);

SELECT * FROM emp_copy ORDER BY employee_id DESC;

SELECT 100 + 200;
SELECT '100' + '200';-- concat다름

SELECT CONCAT('100' ,'200');

-- 명시적 형변환
-- 실수를 정수로 변환 
ROUND(123.444)  TRUNCATE(123.444, 0)


-- CAST ,CONVERT, FORMAT 
SELECT AVG(salary) , CAST(AVG(salary) AS SIGNED INTEGER ) , 
CONVERT(AVG(salary) , SIGNED INTEGER) , 
FORMAT(AVG(salary) , 0)  FROM employees;

-- 
IFNULL(컬럼명, 컬럼NULL대체값) -- NULL 연산식 NULL O
WHERE NULLIF(값1, 값2) IS NULL

IF(T/F , T, F)
SELECT IF(20 > 10, "크다", "작거나 같다");

-- 사원들 COMMISSION_PCT NULL 사원들, 그렇지 않은 사원들
이름   보너스유무
KELLY   못받는다

SELECT FIRST_NAME 이름 , IF(COMMISSION_PCT IS NULL , "못받는다", "받는다") 보너스유무 
FROM employees;

-- 급여정보 연말보너스 지급
20000 이상이면 5000 증가
15000 이상 20000 미만 10000 증가
10000 이상 15000 미만 20000 증가
나머지 30000 증가


SELECT FIRST_NAME 이름, SALARY 급여, 
CASE
 WHEN SALARY >= 20000 THEN SALARY+5000
WHEN SALARY >= 15000  THEN SALARY+10000
WHEN SALARY >= 10000  THEN SALARY+20000
ELSE SALARY+30000
 END 연말보너스
FROM employees;

-- 입사년도 조회 
SELECT HIRE_DATE FROM employees ORDER BY 1;

-- 2002년 이전까지 입사자 30000
-- 2005년 이전까지 입사자 20000
-- 나머지 10000
SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE 입사일, 
CASE  SUBSTR(HIRE_DATE, 1, 4)
 WHEN '2001' THEN SALARY+30000
 WHEN '2002' THEN SALARY+30000
 WHEN '2003' THEN SALARY+20000 
 WHEN '2004' THEN SALARY+20000  
 WHEN '2005' THEN SALARY+20000 
 ELSE SALARY+10000 
 END 연말보너스
FROM employees;

SELECT FIRST_NAME 이름, SALARY 급여, HIRE_DATE 입사일, 
CASE  
 WHEN SUBSTR(HIRE_DATE, 1, 4) IN('2001', '2002') THEN SALARY+30000
 WHEN SUBSTR(HIRE_DATE, 1, 4) IN('2003', '2004', '2005') THEN SALARY+20000 
 ELSE SALARY+10000 
 END 연말보너스
FROM employees;

-- MARIA DB DECODE 없다

-- 날짜함수

--현재 시각 날짜
SELECT CURDATE(), CURRENT_DATE,  CURTIME(), NOW(), SYSDATE();

-- CAST CONVERT FORMAT + DATE_FORMAT(쉽다)

-- 'yyyy-MM-dd HH:mm;ss'==자바

SELECT NOW(), DATE_FORMAT(NOW(),'%Y/%m/%d'), 
DATE_FORMAT(NOW(),'%y/%M/%D'), 
DATE_FORMAT('2022-01-01 00:00:00','%Y/%c/%e') ;

SELECT NOW(), DATE_FORMAT(NOW(),'%Y/%m/%d %W %H:%i:%s') ; 


/*
%Y , %y - 4/2자리년도
%m, %M, %c - 2자리 /영문월이름/1,2자리   월
%d , % e - 2/1,2자리 일
%W - 영문요일
%a - 영문3글자요일

%H , %h - 24/12 시간
%i - 분
%s - 초
*/

-- 연도 추출 함수
SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW()), HOUR(NOW()),  MINUTE(NOW()),  SECOND(NOW());


- 2006년도 입사자 급여조회
SELECT hire_date, salary FROM employees 
WHERE hire_date >= '2006-01-01 00:00:00' 
AND hire_date < '2007-01-01 00:00:00';
SELECT hire_date, salary FROM employees WHERE hire_date LIKE '2006%';
SELECT hire_date, salary FROM employees WHERE substr(hire_date, 1, 4) = '2006'; 
SELECT hire_date, salary FROM employees WHERE instr(hire_date, '2006') = 1;
SELECT hire_date, salary FROM employees WHERE date_format(hire_date, '%Y') = '2006';
SELECT hire_date, salary FROM employees WHERE YEAR(hire_date) = '2006';


SELECT substr(hire_date, 1, 4), date_format(hire_date, '%Y'), YEAR(hire_date), salary FROM employees ;

-- 6월 입사자 
SELECT hire_date, salary FROM employees WHERE hire_date LIKE '_____06%';-- 11
SELECT hire_date, salary FROM employees WHERE substr(hire_date, 6, 2) = '06';

-- 2006-06 
SELECT hire_date, salary FROM employees 
WHERE instr(right(hire_date, CHAR_LENGTH(hire_date)-5), '06') = 1;
SELECT hire_date, salary FROM employees WHERE date_format(hire_date, '%m') = '06';
SELECT hire_date, salary FROM employees WHERE month(hire_date) = '06';



 -- 2006년 이후 입사자 - 2006, 2007, 2008
SELECT hire_date, salary FROM employees WHERE hire_date >= '2006-01-01 00:00:00' 
ORDER BY hire_date; -- 54
SELECT hire_date, salary FROM employees WHERE substr(hire_date, 1, 4) >= '2006'
ORDER BY hire_date; 
SELECT hire_date, salary FROM employees WHERE date_format(hire_date, '%Y') >= '2006'
ORDER BY hire_date;
SELECT hire_date, salary FROM employees WHERE YEAR(hire_date) >= '2006'
ORDER BY hire_date;

 -- 0-월... 2-수 .. 6- 일
 SELECT WEEKDAY(NOW()) ;
 
 사원이름             입사요일
  kelly(대문자변경)   일요일
 
 
 SELECT upper(first_name) 사원이름 , 
 CONCAT(
 case WEEKDAY(hire_date)
 when 0 then '월'
 when 1 then '화'
 when 2 then '수' 
 when 3 then '목'
 when 4 then '금'
 ELSE '주말' 
 END , '요일') 입사요일
 FROM employees;
 
 -- 두 날짜 사이의 계산
 SELECT CURDATE() 오늘날짜,
 SUBDATE( CURDATE(), INTERVAL 1 DAY) 어제날짜,
 ADDDATE(CURDATE(), INTERVAL 1 DAY) 내일날짜,
 ADDDATE(CURDATE(), INTERVAL 1 MONTH ) 한달후날짜, 
 ADDDATE(CURDATE(), INTERVAL 1 YEAR ) 1년후날짜;
 
 -- NOW()  HIRE_date --> 입사한지 얼마나 경과주수 계산
 
 SELECT DATEDIFF(NOW(), hire_date) 경과일수, 
 TRUNCATE( DATEDIFF(NOW(), hire_date) /7, 0) 경과주수,
 truncate(DATEDIFF(NOW(), hire_date)/365, 0) 경과년수,
 PERIOD_DIFF(date_format(NOW(), "%Y%m") , date_format(hire_date, "%Y%m")) 경과개월수
 FROM employees;
 
 -- 트랜잭션 - 여러개 작업 논리 결합 
 -- 여러개 sql 실행 (1개 덩어리) - 계좌이체 1개 작업
 -- a-b 이체도중
 -- a 출금(ok)-(x)-> b 입금(x)--> 이미 처리 sql 취소 (rollback)
 -- a 출금(ok)--> b 입금(ok)--> 2개 sql db 영구 반영(commit)
 -- all or nothing
 -- tcl -transaction control lang.
 -- commit / rollback
 
 -- 마리아db  변수 
SHOW VARIABLES LIKE '%auto%';
SET autocommit = FALSE;
SHOW VARIABLES LIKE '%auto%';