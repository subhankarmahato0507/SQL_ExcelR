select Title, BoxOfficeDollars, OscarWins, CertificateID
from movies.film
Where BoxOfficeDollars > 1e9 and OscarWins >0 ;

select Title, BoxOfficeDollars, OscarWins, CertificateID
from movies.film
where CertificateID =1 or CertificateID =2 ;

select Title, BoxOfficeDollars, OscarWins, CertificateID
from movies.film
Where BoxOfficeDollars > 1e9 and OscarWins >0 and CertificateID in (1,2) ;

select Title, BoxOfficeDollars, OscarWins, CertificateID
from movies.film
Where BoxOfficeDollars > 1e9 and OscarWins >0 and (CertificateID = 1 or CertificateID= 2) ;

select Title, oscarWins
from movies.film
where OscarWins >=5 and OscarWins <=10 ;

select Title, oscarWins
from movies.film
where OscarWins between 5 and 10 ;

select Title, ReleaseDate
from movies.film
where ReleaseDate >='2000-1-1' and ReleaseDate <='2000-12-31' ;

select Title, ReleaseDate
from movies.film
where ReleaseDate between '2000-1-1' and '2000-12-31' ;

select Title, ReleaseDate
from movies.film
where Title = 'king kong' ;

select *
from employees.employees ;


# 1. Display all full time employees and only those contract emp with salary > 80000

select First,Last,status, salary
from employees.employees
where Status = 'Full Time' or (Status ='contract' and Salary >=80000);


# 2. Display hit films which won oscars

select *
from movies.film
where BoxOfficeDollars > BudgetDollars and OscarWins >0 ;

# 3. Display full time employees hired in 2000 year only

select First, Last, Status, HireDate
from employees.employees
where Status = 'Full Time' and HireDate between '200-1-1' and '2000-12-31' ;


# 4. Display both full time and contract employees with jobrating 1

select first,last, status,HireDate
from employees.employees
where Status in ('Full Time', 'Contract') and JobRating =1 ;



# Like (Used for partial match, similar to contains filter in excel)
# % (Zero or any number of characters)
# _ (Single Character)


select Title
from movies.film
where Title like '%Star%' ;

select Title
from movies.film
where Title like 'Star%' ;

select Title
from movies.film
where Title like '%Stars' ;

select Title
from movies.film
where Title like '%Star%' or Title like '%King%' or Title like '%Die%' ;

select Title
from movies.film
where Title like '_a%' ;

select Title
from movies.film
where Title like '__a%' ;

