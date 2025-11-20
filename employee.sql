create database emp;
use emp;

CREATE TABLE dept (
deptno decimal(2,0) primary key,
dname varchar(14) default NULL,
loc varchar(13) default NULL
);

CREATE TABLE emp (
empno decimal(4,0) primary key,
ename varchar(10) default NULL,
mgr_no decimal(4,0) default NULL,
hiredate date default NULL,
sal decimal(7,2) default NULL,
deptno decimal(2,0) references dept(deptno) on delete cascade on update cascade
);
create table incentives (
empno decimal(4,0) references emp(empno) on delete cascade on update cascade,
incentive_date date,
incentive_amount decimal(10,2),
primary key(empno,incentive_date)
);
Create table project (
pno int primary key,
pname varchar(30) not null,
ploc varchar(30)
);
Create table assigned_to (
empno decimal(4,0) references emp(empno) on delete cascade on update cascade,
pno int references project(pno) on delete cascade on update cascade,
job_role varchar(30),
primary key(empno,pno)
);

show tables;
INSERT INTO dept VALUES (10,'ACCOUNTING','MUMBAI');
INSERT INTO dept VALUES (20,'RESEARCH','BENGALURU');
INSERT INTO dept VALUES (30,'SALES','DELHI');
INSERT INTO dept VALUES (40,'OPERATIONS','CHENNAI');
select * from dept;
INSERT INTO emp VALUES (7369,'Adarsh',7902,'2012-12-17','80000.00','20');
INSERT INTO emp VALUES (7499,'shruthi',7698,'2013-02-20','16000.00','30');
INSERT INTO emp VALUES (7359,'Anvitha',7698,'2015-02-22','12500.00','30');
INSERT INTO emp VALUES (7399,'Tanvir',7839,'2008-04-02','29750.00','30');
INSERT INTO emp VALUES (7319,'Ramesh',7698,'2014-09-28','12500.00','20');
INSERT INTO emp VALUES (7234,'Kumar',7839,'2015-05-01','28500.00','30');
INSERT INTO emp VALUES (7269,'Clark',7839,'2017-06-09','24500.00','10');
INSERT INTO emp VALUES (7339,'Scott',7566,'2010-12-09','30000.00','20');
INSERT INTO emp VALUES (7361,'King',null,'2009-11-17','99999.00','10');
INSERT INTO emp VALUES (6666,'Turner',7698,'2010-09-08','15000.00','30');
INSERT INTO emp VALUES (7455,'Adams',7788,'2013-01-12','11000.00','20');
INSERT INTO emp VALUES (7555,'James',7698,'2017-12-03','9500.00','30');
INSERT INTO emp VALUES (3333,'Ford',7566,'2010-12-03','30000.00','20');
drop table emp;

select * from emp;
INSERT INTO incentives VALUES(7499,'2019-02-01',5000.00);
INSERT INTO incentives VALUES(7779,'2019-05-01',4800.00);
INSERT INTO incentives VALUES(7456,'2020-02-06',9800.00);
INSERT INTO incentives VALUES(7499,'2021-02-01',2000.00);
INSERT INTO incentives VALUES(7498,'2019-12-08',6000.00);
INSERT INTO incentives VALUES(7599,'2019-07-18',6700.00);
INSERT INTO incentives VALUES(7429,'2017-02-01',4600.00);
INSERT INTO incentives VALUES(7489,'2019-02-13',3000.00);
INSERT INTO incentives VALUES(7459,'2015-02-01',4000.00);

INSERT INTO project VALUES(101,'AI Project','BENGALURU');
INSERT INTO project VALUES(102,'IOT','HYDERABAD');
INSERT INTO project VALUES(103,'BLOCKCHAIN','BENGALURU');
INSERT INTO project VALUES(104,'DATASCIENCE','MYSURU');
INSERT INTO project VALUES(105,'AUTONOMUS SYSTEMS','PUNE');
select * from project;
INSERT INTO assigned_to VALUES(7499,101,'Software Engineer');
INSERT INTO assigned_to VALUES(7521,101,'Software Architect');
INSERT INTO assigned_to VALUES(7566,101,'Project Manager');
INSERT INTO assigned_to VALUES(7654,102,'Sales');
INSERT INTO assigned_to VALUES(7521,102,'Software Engineer');
INSERT INTO assigned_to VALUES(7499,102,'Software Engineer');
INSERT INTO assigned_to VALUES(7654,103,'Cyber Security');

INSERT INTO assigned_to VALUES(7698,104,'Software Engineer');
INSERT INTO assigned_to VALUES(7900,105,'Software Engineer');
INSERT INTO assigned_to VALUES(7839,104,'General Manager');
select * from assigned_to;
SELECT empno, ename
FROM emp
WHERE empno NOT IN (SELECT empno FROM incentives);
SELECT m.ename, count(*)
FROM emp e,emp m
WHERE e.mgr_no = m.empno
GROUP BY m.ename
HAVING count(*) =(SELECT MAX(mycount)
from (SELECT COUNT(*) mycount
FROM emp
GROUP BY mgr_no) a);
SELECT *
FROM emp m
WHERE m.empno IN
(SELECT mgr_no
FROM emp)
AND m.sal>
(SELECT avg(e.sal)
FROM emp e
WHERE e.mgr_no = m.empno );