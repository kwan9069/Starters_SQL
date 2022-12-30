USE memberdb;

create table member
(
id varchar(10) not null PRIMARY KEY,
pw varchar(10) not NULL,
name varchar(10) ,
phone char(11)  CHECK(phone LIKE '010%'),
email varchar(30) UNIQUE,memberdb
address varchar(50) 
);


DESC member;

-- indate 컬럼(회원가입일) 날짜시간 타입으로 추가
ALTER TABLE member ADD indate DATETIME;
DESC member;

SELECT * FROM member;
INSERT into member VALUES("3","1234","기영","010234343","ndso825@naver.com","삼성동",NOW());

select count(*) from member;

SELECT * FROM member;

SELECT * FROM member where id="3" and pw="1234";