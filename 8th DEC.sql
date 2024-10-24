# 1. Display higest grossing film of each Director, its Title, BoxofficeDollars, FullName

with dmax as
(
select FullName,
BoxofficeDollars,
Title,
row_number() over (partition by FullName order by BoxOfficeDollars desc) as rw
from movies.film f inner join movies.director d 
on f.DirectorID = d.DirectorID
)
select * from dmax
where rw =1
order by BoxofficeDollars desc;


# 2. Display Top 3 RunTime FILMS in each genre, its Title,RunTime, Genre

with gr as
(
select Genre,
RunTimeMinutes,
Title,
row_number() over (partition by Genre order by RunTimeMinutes desc) as rw
from movies.film f inner join movies.Genre g 
on f.GenreID = g.GenreID
)
select*
from gr
where rw <= 3;


# 3. Display Youngest male and female actor details 

with ym as 
(
select FullName, 
Gender,
Dob,
row_number() over (partition by Gender order by Dob desc) as rw
from movies.actor
)
select*
from ym 
where rw=1;


# 4. Display higest and lowest salaried employee details in which Department

with dh as 
(
select Department,
concat(First,' ',Last) as FullName,
Salary,
row_number() over (partition by Department order by salary desc) as hs,
row_number() over (partition by Department order by salary asc) as ls
from employees.employees
)
select*
from  dh
where hs=1 or ls =1;


# Analytical functions (Lead and lag) 
#Lead
select EmployeeId,
concat(First,' ',Last) as FullName,
salary,
Lead(salary) over (order by EmployeeId asc) as ld
from employees.employees;


select EmployeeId,
Department,
concat(First,' ',Last) as FullName,
salary,
Lead(salary,1,0) over (partition by Department order by EmployeeId asc) as ld
from employees.employees;



# Lag
select EmployeeId,
concat(First,' ',Last) as FullName,
salary,
Lead(salary) over (order by EmployeeId asc) as ld
from employees.employees;


with yp as 
(
select 
year(HireDate) as Year,
count(*) as Number_of_Employees
from employees.employees
group by year
)
select year,
Number_of_Employees,
(Number_of_Employees - Lag(Number_of_Employees) over (order by year))/ Number_of_Employees as lg
from yp;


/*Write a query that'll identify returning active users. A returning active user is a user that has made a second purchase 
within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.*/

with py as 
(
select
User_Id,
Item,
Created_At,
Lead(created_at) over (partition by user_Id order by created_At) as nextorder
from amazon_transactions
)
select distinct user_Id
from py
where  datediff(nextorder,created_At) < 7;



create view movies.vwspielberg as
select Title,
BoxofficeDollars,
OscarWins,
Genre,
FullName,
Studio,
Language,
Certificate
from
movies.film f inner join movies.Director  d on f.DirectorId = d. DirectorID
inner join movies.Genre g on f.GenreId = g. GenreID
inner join movies.Language l on f.LanguageId = l.LanguageID
inner join movies.Studio s on f.StudioId = s.StudioID
inner join movies.Country c on f.CountryId = c.CountryID
inner join movies.certificate ce on f.certificateId = ce.CertificateID
where FullName = 'Steven spielberg';

call spfilmsbyDirector('Clint Eastwood');     # calling stored procedure
call spfilmsbyDirector('Steven spielberg'); 

select *
from movies.vwspielberg
where OscarWins >0;

select Genre,
count(*) as Number_of_Films
from movies.vwspielberg
group by Genre;


# View is a virtual table which contains subset of data
# Advantages - Code reusability
# Hiding the datamodel design
# used for row level security (privacy)


# stored Procedure - is a precompiled block of code
# code Reusablity
# Faster Execution  because its reuses the cached execution plan
# Hiding complexity from end user





