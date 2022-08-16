CREATE DATABASE SCENARIO

/*1*/
CREATE TABLE BOOKS
(
	ID INT NOT NULL PRIMARY KEY,
	TITLE VARCHAR(20),
	AUTHOR VARCHAR(20),
	ISBN BIGINT UNIQUE,
	PUBLISHED_DATE DATETIME
)

INSERT INTO BOOKS VALUES(1,'MY FIRST SQL BOOK','MARY PARKER',981483029127,'2021-02-22 12:08:17'),
(2,'MY SECOND SQL BOOK','JOHN MAYER',857300923713,'1972-07-03 09:22:45'),
(3,'MY THIRD SQL BOOK','CARY FLINT',523120967812,'2015-10-18 14:05:44')

/*Create a book table with id as primary key and provide the appropriate data type to other attributes .isbn no should be unique for each book

Write a query to fetch the details of the books written by author whose name ends with er.*/
SELECT * FROM BOOKS WHERE AUTHOR LIKE '%ER'

/*2*/
CREATE TABLE REVIEWS
( 
	ID INT NOT NULL PRIMARY KEY,
	BOOK_ID INT NOT NULL,
	REVIEWER_NAME VARCHAR(20),
	CONTENT VARCHAR(30),
	RATING INT UNIQUE,
	PUBLISHED_DATE DATETIME
)
INSERT INTO REVIEWS VALUES
(1,1,'JOHN SMITH','MY FIRST REVIEW',4,'2017-12-10 05:50:11'),
(2,2,'JOHN SMITH','MYSECOND REVIEW',5,'2017-10-13 15:05:12'),
(3,2,'ALICE WALKER','ANOTHER REVIEW',1,'2017-10-22 23:47:10')

/*Display the Title ,Author and ReviewerName for all the books from the above table*/
SELECT BOOKS.TITLE, BOOKS.AUTHOR, REVIEWS.REVIEWER_NAME 
FROM BOOKS
INNER JOIN  REVIEWS ON BOOKS.ID=REVIEWS.ID

/*3*/
/*Display the reviewer name who reviewed more than one book.*/
SELECT REVIEWER_NAME
FROM REVIEWS
GROUP BY REVIEWER_NAME
HAVING COUNT(REVIEWER_NAME)>1

/*4*/
CREATE TABLE EMPLOYEE 
(
	ID INT NOT NULL PRIMARY KEY,
	NAME VARCHAR(20),
	AGE INT,
	ADDRESS_ VARCHAR(20),
	SALARY FLOAT
)
INSERT INTO EMPLOYEE VALUES
(1,'RAMESH',32,'AHMEDABAD',2000),
(2,'KHILAN',25,'DELHI',1500),
(3,'KAUSHIK',23,'KOTA',2000),
(4,'CHAITALI',25,'MUMBAI',6500),
(5,'HARDIK',27,'BHOPAL',8500),
(6,'KOMAL',22,'MP',4500),
(7,'MUFFY',24,'INDORE',10000)
/*Display the Name for the customer from above 
customer table who live in same address which has character o anywhere in address*/
SELECT NAME FROM EMPLOYEE
WHERE ADDRESS_ LIKE '%O%'

/*5*/
CREATE TABLE ORDERS
(
	OID INT,
	DATE_TIM DATETIME,
	CUSTOMER_ID INT,
	AMOUNT INT
)
INSERT INTO ORDERS VALUES
(102,'2009-10-08 00:00:00',3,3000),
(100,'2009-10-08 00:00:00',3,1500),
(101,'2009-11-20 00:00:00',2,1560),
(103,'2008-05-20 00:00:00',4,2060)

/*Write a query to display the Date,Total no of customer placed order on same Date*/
SELECT DATE_TIM,COUNT(CUSTOMER_ID)
AS 'ORDER PLACED'
FROM ORDERS GROUP BY DATE_TIM

/*6*/
UPDATE EMPLOYEE
SET SALARY = NULL
WHERE NAME LIKE 'MUFFY'

SELECT * FROM EMPLOYEE

SELECT LOWER(NAME) AS 'NULL SALARY' FROM EMPLOYEE WHERE SALARY IS NULL

/*7*/
CREATE TABLE STUDENTDETAILS(
	REGISTERNO INT PRIMARY KEY,
	SNAME VARCHAR(30),
	AGE INT,
	QUALIFICATION VARCHAR(30),
	MNO BIGINT,
	MAIL VARCHAR(30),
	LOCATION VARCHAR(30),
	GENDER CHAR(1)
)

SELECT * FROM STUDENTDETAILS

INSERT INTO STUDENTDETAILS VALUES
(2,'SAI',22,'B.E',9952836777, 'SAI@GMAIL.COM','CHENNAI','M'),
(3 , 'KUMAR',20 ,'BCS',7890125648 , 'Kumar@gmail.com' ,'Madurai', 'M'),
(4 , 'Selvi',22 ,'B.Tech',8904567342 , 'Selvi@gmail.com' ,'Selam', 'F'),
(5 , 'Nisha',25 ,'M.E',7834672310 , 'Nisha@gmail.com' ,'Theni', 'F'),
(6 , 'SaiSaran',21 ,'B.A',7890345678 , 'SaiSaran@gmail.com' ,'Madurai', 'F'),
(7 , 'Tom',23 ,'BCA',89012345675 , 'Tom@gmail.com' ,'Pune', 'M')

SELECT GENDER, COUNT(GENDER) AS 'TOTAL MALE AND FEMALE' FROM STUDENTDETAILS GROUP BY GENDER

/*8*/
CREATE TABLE COURSEDETAILS
(
	CID VARCHAR(20) PRIMARY KEY,
	CNAME VARCHAR(30),
	START_DATE DATE,
	END_DATE DATE,
	FEES INT
)

INSERT INTO COURSEDETAILS VALUES
('DN003','DOTNET','2018-02-01','2018-02-28',15000),
('DV004','DATE VISUALZATION','2018-03-01','2018-04-15',15000),
('JA002','ADVANCED JAVA','2018-01-02','2018-01-20',10000),
('JC001','CORE JAVA','2018-01-02','2018-01-12',15000)

CREATE TABLE COURSEREGISTRATION
(
	REGISTERNO INT,
	CID VARCHAR(20) FOREIGN KEY REFERENCES COURSEDETAILS(CID),
	BATCH VARCHAR(10)
)

SELECT * FROM COURSEREGISTRATION

INSERT INTO COURSEREGISTRATION VALUES
(2,'DN003','FN'),
(3,'DV004','AN'),
(4,'JA002','FN'),
(2,'JA002','AN'),
(5,'JC001','FN')

SELECT COUNT(REGISTERNO) FROM COURSEREGISTRATION

SELECT T1.CNAME , COUNT (T2.REGISTERNO) AS 'TOTAL REGISTRATION'
FROM COURSEDETAILS T1 LEFT JOIN COURSEREGISTRATION T2 ON T1.CID= T2.CID
WHERE START_DATE BETWEEN '2018-01-02' AND '2018-02-28' GROUP BY T1.CNAME

/*9*/
CREATE TABLE CUSTOMERS
( 
	CUSTID INT PRIMARY KEY,
	FIRSTNAME VARCHAR(30),
	LASTNAME VARCHAR(30),
)

INSERT INTO CUSTOMERS VALUES
(1,'GEORGE','WASHINGTON'),
(2,'JOHN','ADAMS'),
(3,'THOMAS','JEFFERNSON'),
(4,'JAMES','MADDINSON'),
(5,'JAMES','MONROE')

CREATE TABLE ORDER2
(
	ORDER_ID INT PRIMARY KEY,
	ORDER_DATE DATE,
	AMOUNT FLOAT,
	CUSTOMER_ID INT FOREIGN KEY REFERENCES CUSTOMERS(CUSTID),
)

INSERT INTO ORDER2 VALUES
(1,'1776-04-04',234.56,1),
(2,'1760-02-14',78.50,3),
(3,'1784-05-23',124.00,2),
(4,'1790-09-03',65.50,3),
(5,'1795-07-21',25.50,4),
(6,'1787-11-27',14.40,5)

SELECT T1.FIRSTNAME, T1.LASTNAME FROM CUSTOMERS T1 JOIN ORDER2 T2 ON T1.CUSTID =T2.CUSTOMER_ID
GROUP BY T1.FIRSTNAME, T1.LASTNAME HAVING COUNT(T2.CUSTOMER_ID) =2

/*10*/
SELECT * FROM STUDENTDETAILS

SELECT REVERSE(SNAME) AS REVERSENAME,UPPER(LOCATION) AS LOCATION FROM STUDENTDETAILS

/*11*/

CREATE TABLE ORDERR
(
	ID INT PRIMARY KEY,
	ORDERDATE DATE,
	ORDERNUMBER INT,
	CUSTOMERID INT,
	TOTALAMOUNT INT
)

CREATE TABLE ORDERITEM
(
	ID INT PRIMARY KEY,
	ORDERID INT,
	PRODUCTID INT,
	UNITPRICE INT,
	QUANTITY INT
)

CREATE TABLE PRODUCT
(	
	ID INT PRIMARY KEY,
	PRODUCTNAME VARCHAR(30),
	SUPPLIERID INT,
	PACKAGE VARCHAR(30),
	ISDISCONTINUED VARCHAR(5)
)

CREATE VIEW 
ORDERVIEW AS SELECT PRODUCTNAME, QUANTITY, ORDERNUMBER FROM
ORDERR O, ORDERITEM I, PRODUCT P WHERE O.ID = I.ID AND O.ID = P.ID 

SELECT * FROM ORDERVIEW

/*12*/
SELECT * FROM STUDENTDETAILS
SELECT * FROM COURSEDETAILS
SELECT * FROM COURSEREGISTRATION

SELECT T1.CNAME FROM STUDENTDETAILS T2 JOIN COURSEREGISTRATION T3 ON T2.REGISTERNO=T3.REGISTERNO
JOIN COURSEDETAILS T1 ON T1.CID = T3.CID WHERE T2.SNAME = 'NISHA'




