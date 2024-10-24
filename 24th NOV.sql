# order by (used for Sorting Purpose)
# Asc, Desc, Multiple Sort, Custom Sort

select 
concat(First,' ', Last) as FullName
,Status
,Salary
from employees.employees 
Order by salary desc ; 

   select 
concat(First,' ', Last) as FullName
,Status
,Salary
from employees.employees 
Order by salary ;                       #by default it will sort in asc order

   select 
concat(First,' ', Last) as FullName
,Status
,Salary
from employees.employees 
Order by salary asc;     


  select 
concat(First,' ', Last) as FullName
,Status
,Salary
from employees.employees 
Order by salary desc 
Limit 3 ; 

  select 
concat(First,' ', Last) as FullName
,Status
,Salary
from employees.employees 
Order by salary asc 
Limit 3 ; 

  select 
concat(First,' ', Last) as FullName
,Status
,Salary
from employees.employees 
Order by salary desc 
Limit 1 offset 2;                       # find top 3 highest so offset is 2 here, when if ask top 5 highest then offset is 4 like that it work



 select 
concat(First,' ', Last) as FullName
,Department
,Status
,Salary
from employees.employees 
Order by Department asc, salary desc;



# Full Time, Contract, Half-Time, Hourly

select
concat(First,' ', Last) as FullName
,Department
,Status
,case
When status = 'Full Time' then 1 
When status = 'Contract' then 2
When status = 'Half-Time' then 3
else 4
end as Sort
from employees.employees 
Order by sort asc;

 
 
 select
concat(First,' ', Last) as FullName
,Department
,Status
,salary
from employees.employees 
order by case
When status = 'Full Time' then 1 
When status = 'Contract' then 2
When status = 'Half-Time' then 3
else 4
end asc, Salary desc ;

 # 1. Display the list of top 5 highest Grossing Film (Based on BoxofficeDolllars)
 
select Title
,BoxofficeDollars
from movies.film 
Order by BoxOfficeDollars desc 
Limit 5;  


 # 2. Display the list of Top 3 Youngest Actor
 
 select 
concat(FirstName,' ', FamilyName) as FullName
,Dob
from movies.actor
Order by Dob desc 
Limit 3; 
 

 # 3. Sort the movie title to display all text title at top, then alphanumeric titles, then numeric titles
 
 select Title
from movies.film 
Order by case 
when Title not regexp'[0-9]' then 1
when Title regexp'[A-Z]' then 2
else 3
end asc, Title asc ; 
 
 # 4. sort the movies by GenreID in asc and then by highest to lowest runtimeminutes
 
 select Title
,GenreID
,RunTimeMinutes
from movies.film 
Order by GenreID asc, RunTimeMinutes desc ;

 
 # 5. sort by Department in asc, then by status in full time, contract, half-time, hourly and then by salary desc
 
 select
concat(First,' ', Last) as FullName
,Department
,Status
,Salary
from employees.employees 
Order by Department asc
,case
When status = 'Full Time' then 1 
When status = 'Contract' then 2
When status = 'Half-Time' then 3
else 4
end asc,
Salary desc ;



# Aggregate Functions (Sum, count, Avg, Max, Min)

# Count(*) - count all rows in the table
# Count(Column) - only Counts the non null values in a column


select
count(*) as Number_of_Films
,count(BoxofficeDollars) as CountBO
,count(case when BoxofficeDollars > BudgetDollars then 1 end) as Hits
,count(case when BoxofficeDollars <= BudgetDollars then 1 end) as Flops
,count(case when boxofficeDollars is null or BudgetDollars is null then 1 end) as cnulls
,max(BoxOfficeDollars) as MaxBO
,avg(RunTimeMinutes) as AvgRunTime
from movies.film ;

select
count(*) as CountNulls
from movies.film 
where BoxOfficeDollars is Null ;
 
 select
 Title
 ,BoxofficeDollars
 ,BudgetDollars
 ,case
 when BoxofficeDollars > BudgetDollars then 1
 end as Hits
 ,case
 when BoxofficeDollars <= BudgetDollars then 1
 end as flop
 ,case
 when boxofficeDollars is null then 1
 end as cnull
 from movies.film ;
 
 
 
 # For TP topics
 
 # RDBMS Basics
 # database basic and architecture
 # select statement with where clause
 # keywords and operators used
 # like , not like, regexp, not regexp
 # basic calculation
 # IF, NESTED IF, CASE
 # ORDER BY - ASC, DESC, MULTIPLE SORT, CUSTOM SORT
 # AGGREGATE FUNCTIONS
 
 
 # 1. Display of count of oscarWining Films
 
 select
 count(case when oscarWins >0 then 1 end) as OscarFilms
 from movies.film;
 
 
 
 # 2. Display the count of hits films which won oscars
 
 select 
 count(case when boxofficeDollars > BudgetDollars and oscarWins >0 then 1 end) as HitOscars
 from movies.film ;
 
 
 # 3. Display the count of permanent employees and temporary employees
 
 select
 count(case when status ='full time' then 1 end) as PermanentEmp
  ,count(case when status !='full time' then 1 end) as TemproraryEmp
 from employees.employees ;
 
 
 # 4. Display the Avg salary of permanent employees and temprorary employees
 
 select
 count(case when status ='full time' then 1 end) as PermanentEmp,
 count(case when status !='full time' then 1 end) as TemproraryEmp,
 avg(case when Status ='full time' then Salary end) as AvgSalaryPermanentEmp,
 avg(case when status !='full time' then salary end) as AvgSalaryTemproraryEmp
 from employees.employees ;
 
 
 
 SELECT
    COUNT(CASE WHEN status = 'full time' THEN 1 END) AS PermanentEmp,
    COUNT(CASE WHEN status != 'full time' THEN 1 END) AS TemporaryEmp,
    AVG(CASE WHEN status = 'full time' THEN salary END) AS AvgPermanentSalary,
    AVG(CASE WHEN status != 'full time' THEN salary END) AS AvgTemporarySalary
FROM employees.employees;

 
 
 
 # 5. Display the count of short films, count of avg length films, count of long films
 
 select 
 count(case when Title = 'short films' then 1 end) as ShortFilms,
 count(case when Title = 'AvgLength' then 1 end) as AvgLengthFilms,
 count(case when Title = 'LongLength' then 1 end) as LongFilms
 from movies.film ;
 
 
 
 SELECT 
    COUNT(CASE WHEN RunTimeMinutes <= 60 THEN 1 END) AS ShortFilms,
    COUNT(CASE WHEN RunTimeMinutes > 60 AND length <= 120 THEN 1 END) AS AvgLengthFilms,
    COUNT(CASE WHEN RunTimeMinutes > 120 THEN 1 END) AS LongFilms
FROM movies.film;


 
 