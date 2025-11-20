show databases;
create database week3;
use week3;
create table branch(branchname varchar(50),branchcity varchar(50),assests real,primary key(branchname));
create table bankaccount(accno integer,branchname varchar(30),balance real,primary key(accno), foreign key (branchname) references branch(branchname));
create table bankcustomer(customername varchar(30),customerstreet varchar(30),customercity varchar(30),primary key (customername));
create table depositer(customername varchar(30),accno integer,primary key(customername,accno),foreign key(customername) references bankcustomer(customername),foreign key(accno) references bankaccount(accno));
create table loan(loannumber int,branchname varchar(30),amount real,primary key(loannumber),foreign key(branchname)references branch(branchname));
insert into branch values('SBI_chamrajpet','banglore',450000);
insert into branch values('SBI_residencyroad','banglore',10000);
insert into branch values('SBI_shivajiroad','bombay',20000);
insert into branch values('SBI_jantamantra','delhi',20000);
insert into branch values('SBI_parlimentroad','delhi',450000);
select * from branch;
insert into loan values(2,'SBI_residencyroad',2000);
insert into loan values(1,'SBI_chamrajpet',1000);
insert into loan values(3,'SBI_shivajiroad',3000);
insert into loan values(4,'SBI_jantamantra',4000);
insert into loan values(5,'SBI_parlimentroad',5000);
select * from loan;
INSERT INTO bankcustomer (CUSTOMERNAME, CUSTOMERSTREET, CUSTOMERCITY) VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

select * from bankcustomer;
INSERT INTO bankaccount (accno,branchname,balance) values
(1, 'SBI_chamrajpet', 2000),
(2, 'SBI_residencyroad', 5000),
(3, 'SBI_shivajiroad', 6000),
(4, 'SBI_parlimentroad', 9000),
(5, 'SBI_jantamantra', 8000),
(6, 'SBI_shivajiroad', 4000),
(7, 'SBI_residencyroad', 4000),
(8, 'SBI_parlimentroad', 3000),
(9, 'SBI_parlimentroad', 5000),
(10, 'SBI_residencyroad', 2000),
(11, 'SBI_jantamantra', 2000);
select * from bankaccount;
INSERT INTO depositer (CUSTOMERNAME, ACCNO) VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11);
select * from depositer; 
select branchname
from branch
where assests > ALL(
select assests 
from branch
where branchcity = 'banglore'
);