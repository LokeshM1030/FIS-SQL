/* PRACTICE ===>*/
create database FISDB

create table tblDepartment
(
	DeptId int primary key,
	DeptName varchar(20),
	DeptLocation varchar(30)
)

create table tblEmployee
(
	Empid int primary key,
	EmpName varchar(30),
	Gender char(7) not null,
	salary float,
	DepId int references tblDepartment(DeptId),
)

sp_help tblEmployee


/*ASSIGNMENT ===>*/
create database Assingment

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

/*WRITE AND EXECUTE THE NECESSARY SQL STATEMENTS TO PERFORM THE FOLLOWING TASKS.*/
/*1. LIST ALL EMPLOYEES WHOSE NAMES BEGIN WITH 'A'*/
SELECT * FROM EMP WHERE ENAME LIKE 'A%';

/*2. SELECT ALL THOSE EMPLOYEES WHO DONT HAVE MANAGER*/
SELECT * FROM EMP WHERE MGRID IS NULL;

/*3. List employee name, number and salary for those employees who earn 
in the range 1200 to 1400.*/
SELECT ENAME,EMPNO,SAL FROM EMP WHERE SAL BETWEEN 1200 AND 1400;

/*4. Give all the employees in the RESEARCH department a 10% pay rise. Verify 
that this has been done by listing all their details before and after the rise.*/
SELECT * FROM EMP WHERE DEPT_NO=20;
UPDATE EMP
SET EMP.SAL += (SAL*0.10)
WHERE EMP.DEPT_NO=20;

/*5. Find the number of CLERKS employed. Give it a descriptive heading.*/
SELECT COUNT(JOB) AS NO_OF_CLERKS
FROM EMP
WHERE JOB='CLERK'

/*6. Find the average salary for each job 
type and the number of people employed in each job.*/
SELECT JOB,AVG(SAL) AS NO_PEOPLE
FROM EMP
GROUP BY JOB;

/*7. List the employees with the lowest and highest salary*/
SELECT MIN(SAL) AS LOWEST_SALARY,MAX(SAL) AS HIGHEST_SALARY
FROM EMP;

/*8. List full details of departments that don't have any employees.*/
SELECT * FROM DEPT
WHERE DEPTNO
NOT IN (SELECT DEPT_NO FROM EMP)

/*9.Get the names and salaries of all the analysts earning more than 1200 
who are based in department 20. Sort the answer by ascending order of name.*/
SELECT ENAME,SAL FROM EMP
WHERE JOB = 'ANALYST' AND DEPT_NO = 20
ORDER BY ENAME;

/* 10. For each department, list its name and number together with the 
total salary paid to employees in that department.*/
SELECT DNAME, DEPTNO, SUM(SAL)
FROM DEPT
JOIN EMP USING (DEPTNO); /*not working*/

/* 11. Find out salary of both MILLER and SMITH.*/
SELECT ENAME,SAL FROM EMP
WHERE ENAME= 'MILLER' OR ENAME='SMITH'

/*12. Find out the names of the employees whose name begin with ‘A’ or ‘M’.*/
SELECT * FROM EMP
WHERE ename LIKE 'A%' OR ename LIKE 'M%';

/*13. Compute yearly salary of SMITH.*/
SELECT ENAME,SUM(12*SAL) AS ANNUAL_SALARY
FROM EMP
WHERE ENAME = 'SMITH'
GROUP BY ENAME;

/*14. List the name and salary for all employees 
whose salary is not in the range of 1500 and 2850*/
SELECT ENAME,SAL
FROM EMP 
WHERE SAL NOT IN 
(SELECT SAL FROM EMP WHERE SAL BETWEEN 1500 AND 2850) 
GROUP BY ENAME,SAL

