# Use constraints

# Constraints - use to enforce  data validation in SQL
# constraints use:
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

