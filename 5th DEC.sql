# Use constraints

# Constraints - use to enforce  data validation in SQL

# Primary Key - cant enter duplicate values (null also not allowed)
# Foreign Key -  Referential Integrity which ensure there is no Orphan Record
# Unique - no duplicate value but single null allowed
# Check -  validation based on custom expression
# Default - 

# length =10 and phone not containing alphabet
# Email should contain @ and end with .com



create database HR ;

Use HR ;


Create table hr.employees
(
EmployeeID int primary key auto_increment,
Employee varchar(500),
Hiredate datetime,
GenderId int,
CityId int,
DepartmentId int,
DesignationId int,
Email varchar(500),
Phone char(10),
Salary double);

Create table hr.Gender
(
GenderId int primary key auto_increment,
Gender varchar (500));

Create table hr.city
(
CityId int primary key auto_increment,
city varchar (500) );

Create table hr.department
(
departmentId int primary key auto_increment,
department varchar (500) );

Create table hr.designation
(
designationId int primary key auto_increment,
designation varchar (500) );




# Add a new column
Alter table hr.employees
add SSN CHAR(10) ;

# Drop a column
Alter table hr.employees
drop column SSN ;

# change column name
Alter table hr.employees
rename column phone to phone_number ;

Alter table hr.employees
modify column email varchar(600);

# Add foreign key constraint
Alter table hr.employees
Add constraint FK_employees_GenderId
foreign key(GenderID) references Gender(GenderID) ;

Alter table hr.employees
Add constraint FK_employees_cityId
foreign key(cityID) references city(cityID) ;

Alter table hr.employees
Add constraint FK_employees_DepartmentId
foreign key(DepartmentId) references Department(DepartmentId) ;

Alter table hr.employees
Add constraint FK_employees_DesignationId
foreign key(DesignationId) references Designation(DesignationId) ;

# Unique key
Alter table hr.employees
Add constraint UK_employees_Email
unique(Email) ;

Alter table hr.employees
Add constraint UK_employees_phone_number
unique(phone_number) ;

# check 
Alter table hr.employees
Add constraint CK_employees_Email
check(Email like '%@%.com') ;

Alter table hr.employees
Add constraint CK_employees_phone_number
check(length(phone_number) = 10 and phone_number not regexp '[A-Z]') ;


# insert use to insert data 

Insert into hr.Gender(Gender)
values('Male'),('Female') ;

Insert into hr.city(city)
values('Bengaluru'),('Mumbai'), ('Chennai'), ('Noida');

Insert into hr.city(city)
values('Pune');

Insert into hr.department(department)
values('IT'),('HR'), ('Sales'), ('Finance');

Insert into hr.designation(designation)
values('Project Manager'),('Software Engineer'), ('Associate Consultant'), ('Test Lead');


Insert into hr.employees
values(default,'Hitesh','2007-1-1',1,1,1,1,'hitesh.analyst1@gmail.com','7204370999',400000),
(default,'Shruthi','2007-1-1',2,1,1,1,'Shruthi.analyst1@gmail.com','7204370993',400000);

Insert into hr.employees(email)
values('hitesh.analyst2@gmail.com');




# Create database by name APP

Create database App;


# Create table Users(Userid, UserName, Loginld(char(6)), Password, Email, Countryld, Planid, Rating)
use app;
Create table App.users
(
Userid int primary key auto_increment,
username varchar(500),
loginid char(6),
Password varchar(500),
Email Varchar(500),
CountryID int,
PlanId int,
Rating int
);

# Create table Plan (Planid, Plan(char(1))
create table app.Plan
(
PlanId int primary key auto_increment,
Plan char(1)
);



# Create table Country (Countryld, Country, Regionld)

CREATE TABLE app.Country (
    CountryId INT PRIMARY KEY AUTO_INCREMENT,
    country VARCHAR(500),
    RegionId INT
);


# Create table Region (Regionld, Region)

Create table app.Region
(
RegionId int primary key auto_increment,
Region  varchar(500));


# Fk-Countryld, Planld in Users... Regionld in Country

Alter table app.users
add constraint FK_users_CountryId
Foreign key (CountryId) references country(countryId) ;

Alter table app.users
add constraint FK_users_PlanId
Foreign key (PlanId) references Plan(PlanId) ;

Alter table app.country
add constraint FK_users_RegionId
Foreign key (RegionId) references Region(RegionId) ;




# Unique - Loginld, Password, Email
Alter table app.users
add constraint UK_Users_LoginId
Unique (LoginId);

Alter table app.users
add constraint UK_Users_Password
Unique (Password);

Alter table app.users
add constraint UK_Users_Email
Unique (Email);



# Plan in plan table should have values A - D

Alter table app.Plan
Add constraint CK_Plan_Plan
check(Plan regexp '[A-D]') ;



# Password should be having min length 6 chars and contain atleast one number,one text and one special character 

Alter table app.users
Add constraint CK_Plan_Password
check(length(Password)>=6 and password regexp '[0-9]'and password regexp '[A-Z]' and
(Password regexp '[~!@#%&*()_{}\/]' or Password like'%^%' or Password like'%$%'or Password like'%|%'));


# Loginld should be six characters exactly, first 3 characters should be numbers, last three characters should be text

Alter table app.users
Add constraint CK_Plan_LoginId
check(length(LoginId)=6 and LoginId regexp '^[0-9]{3}[A-Z]{3}$');        #{3} means its repeat 3 times


# Rating should be 1-5 only
Alter table app.users
Add constraint CK_Plan_Rating
check (Rating between 1 and 5);



Insert into app.Plan(Plan)
values ('A'),('B'),('C'),('D');

Insert into app.Region(Region)
values ('Asia'),('Europe'),('America'),('Australia');

Insert into app.Country(Country,RegionId)
values ('India',1),
('China',1),
('Japan',1),
('France',2),
('Italy',2),
('USA',3),
('Canada',3);

Insert into app.users
values(default,'Hitesh','123abc','Hitesh123*','Hitesh.analyst1@gmail.com',1,1,1),
(default,'Shruthi','122agd','Hitesh123!','Shruthim@gmail.com',1,1,1);



set sql_safe_updates =0;              #use when error is comming to do safe update 



Create table employees.empcopy as 
select *
from movies.film;

Create table movies.filmcopy as 
select *
from movies.film;

Create table movies.starfilms as 
select *
from movies.film
where Title regexp 'star';

Insert into movies.starfilms 
select *
from movies.film
where Title regexp 'King';


