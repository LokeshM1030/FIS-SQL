/*Assignment 2*/

CREATE DATABASE ASSIGNMENT2

create table DEPT
(
	deptno int primary key,
	dname varchar(20),
	loc varchar(10)
)
create table EMP
(
	empno int not null primary key,
	ename varchar(20),
	job varchar(20),
	age int,
	mgrid int,
	hiredate DATE,
	sal int,
	comm int,
	dept_no int references DEPT(deptno)
)


ALTER TABLE EMP
DROP COLUMN AGE;
insert into EMP(empno,ename,job,mgrid,hiredate,sal,comm,dept_no) 
values(7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-10-28',1250,1400,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-10-08',1500,0,30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,NULL,10)

INSERT INTO DEPT(deptno,dname,loc)
VALUES(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON')

SELECT * FROM DEPT
SELECT * FROM EMP

/*1. Retrieve a list of MANAGERS.*/
SELECT * FROM EMP WHERE JOB= 'MANAGER'

/*2.  Find out the names and salaries of all employees earning more than 1000 per 
month*/

SELECT ENAME, SAL FROM EMP WHERE SAL>1000

/*3.  Display the names and salaries of all employees except JAMES*/
SELECT ENAME,SAL FROM EMP WHERE ENAME<>'JAMES' 

/*4.Find out the details of employees whose names begin with ‘S’*/
SELECT * FROM EMP WHERE ENAME LIKE 'S%'

/*5.Find out the names of all employees that have ‘A’ anywhere in their name.*/
SELECT ENAME FROM EMP WHERE ENAME LIKE '%A%'

/*6.Find out the names of all employees that have ‘L’ as their third character in 
their name.*/
SELECT ENAME FROM EMP WHERE ENAME LIKE '___L%'

/*7.Compute daily salary of JONES.*/
SELECT SAL/30 AS 'DAILY SALARY' FROM EMP WHERE ENAME = 'JONES'

/*8.Calculate the total monthly salary of all employees. */
SELECT SUM(SAL) as 'TOTAL MONTHLY SALARY' FROM EMP

/*9.Print the average annual salary .*/
SELECT AVG(SAL*12) AS 'AVERAGE ANNUAL SALARY' FROM EMP

/*10.Select the name, job, salary, department number of all employees except 
SALESMAN from department number 30.*/
SELECT ENAME, JOB, SAL, DEPT_NO FROM EMP WHERE JOB NOT LIKE 'SALESMAN' AND DEPT_NO = 30

/*11. List unique departments of the EMP table.*/
SELECT DNAME FROM DEPT WHERE DEPTNO IN (SELECT DISTINCT (DEPT_NO) FROM EMP)

/*12.List the name and salary of employees who earn more than 1500 and are in department 10 
or 30. Label the columns Employee and Monthly Salary respectively.*/
SELECT ENAME AS 'EMPLOYEE', SAL AS 'MONTHLY SALARY'FROM EMP WHERE SAL>1500 AND (DEPT_NO = 10 OR DEPT_NO=30)

/*13.Display the name, job, and salary of all the employees whose job is MANAGER or 
ANALYST and their salary is not equal to 1000, 3000, or 5000.*/
SELECT ENAME,JOB,SAL FROM EMP 
WHERE JOB LIKE 'MANAGER' OR JOB LIKE 'ANALYST' AND (SAL != 1000 OR SAL !=3000 OR SAL !=5000)

/*14. Display the name, salary and commission for all employees whose commission 
amount is greater than their salary increased by 10%. */
SELECT ENAME, SAL, COMM FROM EMP WHERE COMM > (SAL+ 0.1*SAL)

/*15. Display the name of all employees who have two Ls in their name and are in 
department 30 or their manager is 7782*/
SELECT ENAME FROM EMP WHERE ENAME LIKE '%L%L%' AND (dept_no=30 OR mgrid=7782)

/*16. Display the names of employees with experience of over 10 years and under 20 yrs.
 Count the total number of employees.*/
SELECT ENAME FROM EMP WHERE 20< DATEDIFF(YEAR,HIREDATE,GETDATE()) AND DATEDIFF(YEAR,HIREDATE,GETDATE())>10 

/*17. Retrieve the names of departments in ascending order and their employees in 
descending order. */
SELECT d.DNAME, E.ENAME FROM EMP E ,DEPT d ORDER BY D.DNAME ASC, E.ENAME DESC

/*18. Find out experience of MILLER.*/
SELECT DATEDIFF(YEAR, HIREDATE, GETDATE()) AS EXPERIENCE FROM EMP WHERE ENAME='MILLER'
