# Triggers

# Triggers is a block of code which runs in response to another event

Create database triggers3 ;

use triggers3 ;

Create table customers
(
custid int primary key auto_increment
,custname varchar(500)
,age int
) ;

Delimiter // 

Create trigger trageinsert
before insert on customers
for each row
Begin

if new.age < 0 then
set new.age = 18 ;
end if ;

End //

Delimiter ;

Insert into customers(custname,age)
Values('Hitesh',36)
,('Raj',25) ;

Insert into customers(custname,age)
Values('Shruthi',-5) ;

set sql_safe_updates = 0 ;
Delete from customers ;

Select * from customers ;

Create table emp
(
empid int primary key auto_increment
,empname varchar(500)
,dob datetime
); 

Create table audit
(
auditid int primary key auto_increment
,empid int
,msg varchar(700)
);


Delimiter //

Create trigger trcheckdob
after insert on emp
for each row
Begin

if new.dob is null then 
Insert into audit(empid,msg)
Values(new.empid,concat('Hi ',new.empname,' Please Update your Dob'));
end if ;

End //

Delimiter ;

Insert into emp(empname,dob)
Values('Hitesh','1986-7-2')
,('Raj','2000-1-1');

Insert into emp(empname)
Values('Shruthi');

Select * from audit ;

Create table employees
(
empid int primary key auto_increment
,empname varchar(500)
,salary double
) ;

Insert into employees(empname,salary)
Values('Hitesh',80000)
,('Raj',100000)
,('Naresh',120000) ;

Delimiter //

Create trigger trsalaryupdate
before update on employees
for each row 
Begin

if new.salary < 50000 then
set new.salary = 70000 ;
elseif new.salary < 80000 then
set new.salary = 80000 ;
end if ;

End //

Delimiter ;

set sql_Safe_updates = 0 ;
Update employees
set Salary = 75000
where Empname = 'Hitesh' ;

Select * from employees ;

Create table esalary
(
empid int primary key auto_increment
,valid_from datetime
,salary double
) ;

Insert into esalary(valid_From,Salary)
Values('2007-1-1',90000)
,('2010-1-1',80000)
,('2013-1-1',100000) ;

Create table delsalary
(
eid int primary key
,valid_from datetime
,salary double
,deldate timestamp default now()
) ;

Delimiter //

Create trigger trdelsalary
before delete on esalary
for each row
Begin

Insert into delsalary(eid,valid_from,salary)
values(old.empid,old.valid_from,old.salary);

End //

Delimiter ;

Delete from esalary
where empid = 3; 

Select * from delsalary ;

Select *
from movies.film 
Where OscarWins > 0 ;

Select
OscarWins
,Count(*) as Number_of_Films
from movies.film
Group by OscarWins 
Order by OscarWins ;

# 5
# 1,2,3,4,5

Call sploop(10);

