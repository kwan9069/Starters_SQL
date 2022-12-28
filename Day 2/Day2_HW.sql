CREATE TABLE menu(
product_code INT(5) NOT null PRIMARY KEY,
product_name CHAR(100) UNIQUE,
price INT(5) CHECK(price >=100 AND price <= 10000),
inventory INT(3) CHECK(inventory >=0),
spec_exp varCHAR(4000),
img_file CHAR(50));

CREATE TABLE customer(
user_id CHAR(30) NOT NULL PRIMARY key,
customer_name CHAR(30) NOT NULL,
email CHAR(30) UNIQUE,
phone_number CHAR(11) check (phone_number LIKE '010%'),
start_date DATETIME,
balance INT(5) CHECK(balance >=0));


-- DROP TABLE customer;
-- DROP TABLE menu;
-- DROP TABLE ORDERS;
-- SELECT * FROM menu;
-- SELECT * FROM CUSTOMER;


CREATE TABLE orders(
order_code INT(5) PRIMARY KEY,
customer_code CHAR(30),
prod_code INT(5),
purchased_amt INT(3) CHECK(purchased_amt <=100),
order_time DATETIME,
CONSTRAINT ord_made FOREIGN KEY(customer_code) REFERENCES customer(user_id),
CONSTRAINT ord_made2 FOREIGN KEY(prod_code) REFERENCES menu(product_code));


INSERT INTO menu VALUES (1,'아메리카노', 2000, 100,'핫,아이스 선택가능:추가요금없음', 'americano.jpg');
INSERT INTO menu VALUES (2, '카페라떼', 3000, 100 , '두유 변경가능:추가요금없음','latte.jpg');
INSERT INTO menu VALUES (3, '딸기바나나쥬스', 3000, 50 ,'딸기싱싱','ddalba.jpg');
INSERT INTO menu VALUES(4, '치즈케익', 5000, 10, '사이즈10*10','cheesecake.jpg');
INSERT INTO menu VALUES(5, '클럽샌드위치', 4500, 10, '치킨,베이컨선택가능:4조각','sandwich.jpg');

INSERT INTO CUSTOMER VALUES('jung1', '유정은', 'jung1@kitri.com', '0102223333', '2022-12-26', 30000);

INSERT INTO CUSTOMER VALUES('inchul1', '신인철', 'in1@bit.com' ,'0103335677', '2022-11-26' ,40000);

INSERT INTO CUSTOMER VALUES('hee1', '황희정', 'heejung1@multi.com', '0102224444', '2021-12-26', 50000);

SELECT user_id, balance FROM customer WHERE customer_name="황희정";

SELECT product_code FROM menu WHERE product_name="클럽샌드위치";


Insert INTO orders VALUES(1,'hee1',5,2,'2022-12-26 17:57:00');

UPDATE menu
SET inventory=inventory-2
WHERE product_name="클럽샌드위치";

UPDATE customer 
SET balance=balance-(4500*2)
WHERE user_id="hee1";

SELECT user_id,customer_name,balance
FROM customer WHERE product_code=5;

SELECT purchased_amt FROM orders WHERE customer_code="

SELECT customer_name,balance, 


