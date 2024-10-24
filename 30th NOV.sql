
# Group by functions- use when aggregate and non-aggregate function both are there
# here aggregate fn are count and avg   &   non -aggregate fn are department

select Department,
count(*) as Number_of_Employees,
avg(salary) as AvgSalary
from employees.employees
group by Department 
having Number_of_Employees >20                  # Where clause is not use when aggregate fn is there , use having clause  here
order by department ;

select*
from employees.employees;


select Department, status,
count(*) as Number_of_Employees,
avg(salary) as AvgSalary
from employees.employees
group by Department, status 
order by department ;


select Department,
count(*) as Number_of_Employees,
count(case when status = 'Full Time' then 1 end) as PermanentEmp,
count(case when status != 'Full Time' then 1 end) as TemporaryEmp
from employees.employees
group by Department
order by department ;


select Department,
case
when status = 'Full Time' then 'Permanent Emp'
else 'Temporary Emp'
end as EmpType,
count(*) as Number_of_Employees
from employees.employees
group by Department, EmpType
order by department ;

select
OscarWins,
count(*) as Number_of_Films
from movies.film
group by OscarWins
Order by OscarWins;


# 1. Display count of tranctions, deposit count and withdraw count by each userId

select  UserID,
count(*) as Number_of_Transactions,
count(case when Transactiontype = 'Deposit' then 1 end )as DepositeCount,
count(case when Transactiontype = 'Withdraw' then 1 end )as WithdrawCount
from paypal.accountmaster
group by userID ;



# 2. Display total deposite, total withdraw and final balance of each User

select  UserID,
sum(case when Transactiontype ='Deposit' then Amount else 0 end ) as TotalDeposit,
sum(case when Transactiontype ='Withdraw' then Amount else 0 end ) as TotalWithdraw,
sum(case when Transactiontype ='Deposit' then Amount else 0 end ) - sum(case when Transactiontype ='Withdraw' then Amount else 0 end ) as final
from paypal.accountmaster
group by userID ;


# 3. Display the list of films with Same title for more then one film

select Title,
count(*) as Number_of_Films
from movies.film
group by Title
having Number_of_Films >1 ;
 


# 4. Display the most common family name among all actors

select FamilyName,
count(*) as Number_of_Actors
from movies.actor
group by FamilyName
where FamilyName is not NULL
Order by Number_of_Actors desc ;


select FamilyName,
count(*) as Number_of_Actors
from movies.actor
having FamilyName is not NUll
having FamilyName

Order by Number_of_Actors desc ;



# Date Functions

select
curdate() as Today,
curdate() as ctime,
now() as now,
year(curdate()) as year,
month(curdate()) as Month,
day(curdate()) as Day,
quarter(curdate()) as Qtr,
week(curdate()) as Wk,
monthname(curdate()) as MonthText,
dayname(curdate()) as DayText,
date_add(curdate(), Interval 1 year) as DA,                  #today date
date_add(curdate(), Interval 1 day) as DA,                   #tomorrow date
date_add(curdate(), Interval -1 day) as DA,                  # Yesterday
date_add(date_add(curdate(), Interval 2 Month), Interval 2 Day)as DA,
datediff('2024-11-30',curdate()) as df,
timestampdiff(Year, curdate(),'2024-11-30') as Tm,
timestampdiff(month, curdate(),'2024-11-30') as Tm,
timestampdiff(Quarter, curdate(),'2024-11-30') as Tm  ;       # how many qrt are completed?