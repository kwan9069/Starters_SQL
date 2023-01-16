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

SELECT * FROM deletedmember;

INSERT into member VALUES("maria","maria","marine","010234340","no825@naver.com","삼성동",NOW());

DELETE FROM member WHERE id ="영삼";

DESC member;


INSERT into member VALUES("maria","3542","가영","010238493","nds15@naver.com","삼성동",NOW());
INSERT into member VALUES("oracle","1234","구영","010233357","ndrwo825@naver.com","삼성동",NOW());
INSERT into member VALUES("test","1234","밍영","010234334","ndsowe25@naver.com","삼성동",NOW());
INSERT into member VALUES("mysql","1234","퀴영","0102345133","ndswerq825@naver.com","삼성동",NOW());



CREATE TABLE board
(seq INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
title VARCHAR(100),
contents TEXT,
writer VARCHAR(10),
viewcount INT(10) DEFAULT 0,
writingtime DATETIME DEFAULT NOW());

ALTER TABLE board 
ADD CONSTRAINT FOREIGN KEY(writer) REFERENCES member(id) 
ON DELETE CASCADE
ON UPDATE CASCADE;

SELECT * FROM board;

INSERT INTO board(title, contents, writer) VALUES
('게시판개설','축하합니다','maria'),
('두번째','나두요','oracle'),
('무엇이든지 질문하세요','스프링으로 만드나요?','test'),
('스프링문의','스프링답변','mysql'),
('mybatis 문의 ','mybatis 답변','maria'),
('스프링이랑mybatis','연결합니다','maria');


SELECT * FROM board;
SELECT * FROM member;

SELECT USER(),DATABASE();

SELECT id,NAME,title,contents,writingtime
FROM member m JOIN board b ON 
m.id=b.writer
WHERE id='maria';

SELECT id,NAME,title,contents,writingtime
FROM member m JOIN board b ON 
m.id=b.writer
WHERE id='oracle';

SELECT id,NAME,title,contents,writingtime
FROM member m JOIN board b ON 
m.id=b.writer
WHERE id='mysql';

SELECT id,NAME, ifnull(title,'글없음') AS title,ifnull(writingtime,'시각모름') AS time
FROM member m LEFT outer JOIN board b ON 
m.id=b.writer
WHERE id='maria';
