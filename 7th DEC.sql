select FullName,
Count(*) as Number_of_Films,
Sum(oscarWins) as TotalOscars,
Avg(BoxOfficeDollars) as AvgBo
from movies.film f inner join movies.Director d 
on f.DirectorID = d.DirectorID
Group by FullName;

select Genre,
Avg(RunTimeMinutes) as AvgRunTime
from movies.film f inner join movies.Genre g 
on f.GenreID = g.GenreID
Group by Genre
order by AvgRunTime desc;


# Find the number of hit films, number of flop films in each Genre

Select Genre,
Count(*) as Number_of_Films, 
count(case when BoxofficeDollars > BudgetDollars then 1 end ) as HitFilms,
count(case when BoxofficeDollars <= BudgetDollars then 1 end ) as FlopFilms,
count(case when BoxofficeDollars is null or BudgetDollars is null  then 1 end ) as cnull
from movies.film f inner join movies.Genre g 
on f.GenreID = g.GenreID
group by Genre;


select Title,
BoxofficeDollars,
OscarWins,
Genre,
FullName,
Studio,
Language,
Certificate
from movies.film f inner join movies.Director  d on f.DirectorId = d. DirectorID
inner join movies.Genre g on f.GenreId = g. GenreID
inner join movies.Language l on f.LanguageId = l.LanguageID
inner join movies.Studio s on f.StudioId = s.StudioID
inner join movies.Country c on f.CountryId = c.CountryID
inner join movies.certificate ce on f.certificateId = ce.CertificateID;


select FullName,
studio,
count(*) as Number_of_Films
from movies.film f inner join movies.Director d on f.DirectorID=d. DirectorId
inner join movies.studio s on f.StudioID = s. StudioID
group by FullName, Studio;


# 1. Display the list of Actors who are also Directors

select a.FullName as Actor,
d.FullName as Director
from movies.actor a inner join movies.director d
on a.FullName = d.FullName;


# 2. Display the list of Actors only (they should not be directors also)

select a.FullName,
d.FullName  
from movies.actor a left join movies.director d
on a.FullName = d.FullName
where d.FullName is null;

# 3. Display the list of Director only (they should not be actors also)

select a.FullName,
d.FullName  
from movies.actor a right join movies.director d
on a.FullName = d.FullName
where a.FullName is null;


# 4. Display the list of actor who are younger then the youngest Director

select FullName,
Dob 
from movies.actor
where Dob > (Select Max(Dob) from movies.director);


# 5. Department, Max Salary in each Department, EmployeeName who got max salary

select Department,
Max(salary) as MaxSalary
from employees.employees
group by Department;                    # here we not use full_name and not do group by full_name ---->some limitation -->use window function


# Window Functions
# Any Function used with over clause is called Window Function

# Aggregate Functions (Row_Number, Rank, DenseRank)
# Anaytical Functions (Lead,Lag)

select Department,
salary,
concat(First,' ',Last) as FullName,
Row_number() over (order by salary desc) as rw
from employees.employees;

select Department,
salary,
concat(First,' ',Last) as FullName,
Row_number() over (partition by Department order by salary desc) as rw
from employees.employees;


# here we use CTE (common temprorary Expression) as name dmax

With dmax as 
(
select Department,
status,
salary,
concat(First,' ',last) as FullName,
Row_number() over (partition by Department,status order by salary desc) as rw
from employees.employees
)
select Department, status, salary, FullName
from dmax
where rw =1;




select Department,
salary,
concat(First,' ',last) as FullName,
Row_number() over ( order by salary desc) as rw,
Rank() over (order by salary desc) as rnk,
dense_rank() over (order by salary desc) as drnk
from employees.employees;


set sql_safe_updates =0;
update employees.employees
set salary = 89740
where concat(First,' ',Last) ='John Cameron';

With dt as 
(
select Department,
salary,
concat(First,' ',last) as FullName,
Row_number() over ( order by salary desc) as rw,
Rank() over (order by salary desc) as rnk,
dense_rank() over (order by salary desc) as drnk
from employees.employees
)
select *
from dt
where drnk <=3;