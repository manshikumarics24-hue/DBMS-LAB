create database supplier;
use supplier;
create table suppliers(sid int primary key,sname varchar(50),city varchar(100));
insert into suppliers values(10001,'acme widget','bangalore');
insert into suppliers values(10002,'johns','kolkata');
insert into suppliers values(10003,'vimal','mumbai');
insert into suppliers values(10004,'reliance','delhi');
select * from suppliers;
create table parts(pid int primary key,pname varchar(50),color varchar(100));
insert into parts values(20001,'book','red');
insert into parts values(20002,'pen','red');
insert into parts values(20003,'pencil','green');
insert into parts values(20004,'mobile','green');
insert into parts values(20005,'charger','black');
select * from parts;
create table catalog(sid int references suppliers(sid),pid int references parts(pid),cost int);
drop table catalog;
insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);
insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);
select * from catalog;
SELECT DISTINCT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid;



SELECT s.sname
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
JOIN parts p ON c.pid = p.pid
WHERE p.color = 'red'
GROUP BY s.sname
HAVING COUNT(DISTINCT p.pid) = (
    SELECT COUNT(*) FROM parts WHERE color = 'red'
);

SELECT p.pname
FROM parts p
JOIN catalog c ON p.pid = c.pid
JOIN suppliers s ON s.sid = c.sid
WHERE s.sname = 'acme widget'
AND p.pid NOT IN (
    SELECT c2.pid
    FROM catalog c2
    WHERE c2.sid <> (
        SELECT sid FROM suppliers WHERE sname = 'acme widget'
    )
);




SELECT DISTINCT c.sid
FROM catalog c
JOIN (
    SELECT pid, AVG(cost) AS avg_cost
    FROM catalog
    GROUP BY pid
) AS avg_table
ON c.pid = avg_table.pid
WHERE c.cost > avg_table.avg_cost;



SELECT c.pid, s.sname
FROM catalog c
JOIN suppliers s ON c.sid = s.sid
JOIN (
    SELECT pid, MAX(cost) AS max_cost
    FROM catalog
    GROUP BY pid
) AS m ON c.pid = m.pid AND c.cost = m.max_cost;



SELECT p.pname, s.sname, c.cost
FROM catalog c
JOIN parts p ON c.pid = p.pid
JOIN suppliers s ON c.sid = s.sid
WHERE c.cost = (SELECT MAX(cost) FROM catalog);


SELECT s.sname
FROM suppliers s
WHERE s.sid NOT IN (
    SELECT c.sid
    FROM catalog c
    JOIN parts p ON c.pid = p.pid
    WHERE p.color = 'red'
);




SELECT s.sname, SUM(c.cost) AS total_value
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
GROUP BY s.sname;





SELECT s.sname
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
WHERE c.cost < 20
GROUP BY s.sname
HAVING COUNT(*) >= 2;






SELECT c.pid, p.pname, s.sname, c.cost
FROM catalog c
JOIN parts p ON c.pid = p.pid
JOIN suppliers s ON c.sid = s.sid
WHERE c.cost = (
    SELECT MIN(cost)
    FROM catalog
    WHERE pid = c.pid
);





CREATE VIEW supplier_part_count AS
SELECT s.sname, COUNT(c.pid) AS total_parts
FROM suppliers s
LEFT JOIN catalog c ON s.sid = c.sid
GROUP BY s.sname;




CREATE VIEW most_expensive_supplier AS
SELECT c.pid, p.pname, s.sname, c.cost
FROM catalog c
JOIN parts p ON c.pid = p.pid
JOIN suppliers s ON c.sid = s.sid
WHERE c.cost = (
    SELECT MAX(cost)
    FROM catalog
    WHERE pid = c.pid
);





CREATE TRIGGER prevent_low_cost
BEFORE INSERT ON catalog
FOR EACH ROW
BEGIN
    IF NEW.cost < 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cost cannot be less than 1';
    END IF;
END;





CREATE TRIGGER set_default_cost
before insert on catalog
for each row
set new.cost=IFNULL(new.cost,10);
