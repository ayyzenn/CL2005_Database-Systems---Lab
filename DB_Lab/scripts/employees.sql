/*
add any comments
*/


DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;


DROP TABLE IF EXISTS emp;
DROP TABLE IF EXISTS dept;
DROP TABLE IF EXISTS salgrade;


CREATE TABLE dept (
	deptno INT NOT NULL PRIMARY KEY,
	dname VARCHAR(10) NOT NULL,
	location VARCHAR(10) NOT NULL
);

CREATE TABLE emp (
	empno INT NOT NULL,
	ename VARCHAR(10) NOT NULL,
	job VARCHAR(10) NOT NULL,
	mgr INT NULL,                              -- Employees Manager id  
	hiredate DATE NOT NULL,
	salary INT NOT NULL,
	commission INT NULL,
	deptno INT NOT NULL,
	PRIMARY KEY (empno),
	FOREIGN KEY (deptno) 
         REFERENCES dept(deptno)
                
);




/*
Salgrade table keeps the grades respective to the salary range (low to high) provided.
*/
CREATE TABLE salgrade (
       grade INT NOT NULL,
       losal INT NOT NULL,                 # Low Salary  
       hisal INT NOT NULL				   # High Salary
);


INSERT INTO dept VALUES (10, 'Accounting', 'New York');
INSERT INTO dept VALUES (20, 'Research', 'Dallas');
INSERT INTO dept VALUES (30, 'Sales', 'Chicago');
INSERT INTO dept VALUES (40, 'Operations', 'Boston');




INSERT INTO `emp` (`empno`, `ename`, `job`, `mgr`, `hiredate`, `salary`, `commission`, `deptno`) VALUES
(7369, 'Smith', 'Clerk', 7902, '2021-07-31', 1200, NULL, 20),
(7499, 'Allen', 'Salesman', 7566, '2021-07-31', 2000, 500, 30),
(7521, 'Ward', 'Salesman', 7698, '2021-07-31', 1650, 800, 30),
(7566, 'Jones', 'Manager', 7839, '2021-07-31', 3375, NULL, 20),
(7654, 'Martin', 'Salesman', 7698, '2021-07-31', 1650, 1400, 30),
(7698, 'Blake', 'Manager', 7839, '2021-07-31', 3250, NULL, 30),
(7782, 'Clark', 'Manager', 7839, '2021-07-31', 2850, NULL, 10),
(7788, 'Scott', 'Analyst', 7566, '2021-07-31', 3500, NULL, 20),
(7813, 'David', 'Clerk', 7788, '2021-07-31', 1500, NULL, 20),
(7839, 'King', 'President', NULL, '2021-07-31', 6500, NULL, 10),
(7844, 'Turner', 'Salesman', 7698, '2021-07-31', 1900, 0, 30),
(7876, 'Adams', 'Clerk', 7788, '2021-07-31', 1500, NULL, 20),
(7900, 'James', 'Clerk', 7698, '2021-07-31', 1350, NULL, 30),
(7902, 'Ford', 'Analyst', 7566, '2021-07-31', 3500, NULL, 20),
(7934, 'Miller', 'Clerk', 7782, '2021-07-31', 1700, NULL, 10);



INSERT INTO salgrade VALUES (1, 1100, 1600);
INSERT INTO salgrade VALUES (2, 1601, 1800);
INSERT INTO salgrade VALUES (3, 1801, 2900);
INSERT INTO salgrade VALUES (4, 2901, 3900);
INSERT INTO salgrade VALUES (5, 3901,10000);
