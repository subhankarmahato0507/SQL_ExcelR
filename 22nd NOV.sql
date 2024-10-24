  # Regexp (Used for partial match, similar to contains filter in excel)
  
  # ^ (starts with)
  # $ (Ends with )
  # | (or)
  # [] (Range of values)
  # {} (Repeat n times)
  
  
select  Title
 from movies.film
 where Title regexp 'Star' ;
 
 select  Title
 from movies.film
 where Title not regexp 'Star' ;
 
 
 SELECT 
    Title
FROM
    movies.film
WHERE
    Title regexp 'Stars$';
    
    
 select  Title
 from movies.film
 where Title regexp 'Star |king |Die' ;
 
  select  Title
 from movies.film
 where Title regexp '^Star|king|Die$' ;
 
 
 
 select  Title
 from movies.film
 where Title regexp '[xyz]' ; 
 
  select  Title
 from movies.film
 where Title regexp 'x|y|z' ; 
 
  select  Title
 from movies.film
 where Title regexp '[uvwxyz]' ; 
 
   select  Title
 from movies.film
 where Title regexp '[u-z]' ;
 
    select  Title
 from movies.film
 where Title regexp '^[u-z]' ;
 
    select  Title
 from movies.film
 where Title regexp '[0-9]' ;
 
     select  Title
 from movies.film
 where Title regexp 'e{2}' ; # its takes 'ee'
 
 
  # 1. Display the list of films which contains only numbers
 
 select *
 from movies.film
 where Title not regexp '[A-Z]';
 
 
 # 2. Display the list of films which start with number and does not end with number
 
  select *
 from movies.film
 where Title regexp'^[0-9]' and Title not regexp '[0-9]$';
 

 # 3. Display the list of films which contains die or start with number or end with x,y,z
 
   select *
 from movies.film
 where Title regexp'Die|^[0-9]|[xyz]$';
 
    select Title 
 from movies.film
 where Title regexp'Die|^[0-9]|[xyz]$';
 
 
 # 4. Display the list of films which has number in first two characters
 
 select *
 from movies.film
 where substring(title,1,2) regexp '^[0-9]+$'; 
 
 
 select *
 from movies.film
 where Title regexp'^[0-9]{2}' ;
 
 
 # 5. Display the list of films which start with c or h but ends with od
 
select Title
from movies.film
where Title regexp '^(c|h)' and Title regexp 'od$' ;

 
 select Title
from movies.film
where Title regexp '^c|^h' and Title regexp 'od$' ;
 
 
 # 6. Display the list of films which is second part of that movie series
 
 select *
  from movies.film
  where Title regexp '2|II' and Title not regexp 'III' ;
 
 select *
  from movies.film
  where Title like '%2%' or (Title like '%II%' and Title not like '%III%') ;
  
  
  select Title, BoxofficeDollars
  from movies.film
  where BoxofficeDollars is null ;
  
    select Title, BoxofficeDollars
  from movies.film
  where BoxofficeDollars is not null ;
  
  select 
   Title Moviename
  ,BoxofficeDollars Boxoffice
  ,BudgetDollars Budget
  ,BoxofficeDollars - BudgetDollars as PL
  from movies.film ;
  
   select 
   Title as Moviename
  ,BoxofficeDollars as Boxoffice
  ,BudgetDollars as Budget
  ,BoxofficeDollars - BudgetDollars as PL
  from movies.film ;
  
 
  select 
   Title as 'Movie Name'
   ,RunTimeMinutes
   ,RunTimeMinutes/60 as Hours
   ,round(RunTimeMinutes/60) as rhours
   ,floor(RunTimeMinutes/60) as fhours        # Previous whole number 
   ,ceiling(RunTimeMinutes/60) as chours      # Next Whole Number
   
   ,RunTimeMinutes mod 60 as minutes
   ,Mod (RunTimeMinutes,60) as minutes2       # Mod gives remainder
   ,RunTimeMinutes % 60 as minutes3
   
   from movies.film ;
 
 
 select 
 First,last,concat( First,' ',Last) as FullName
 from employees.employees ;
 
 
 
   select
   Title as MovieName
   ,RunTimeMinutes
   ,Concat(floor(RunTimeMinutes/60), ' hours ', RunTimeMinutes mod 60,'minutes') as Duration  
   from movies.film ;
   
   
   select
   concat(First,' ',Last) as FullName
   ,status
   ,salary
   ,Salary * 0.1 + Salary as NewSalary
   ,Salary * 1.1 as NewSalary2
   from employees.employees ;
   
	select
   concat(First,' ',Last) as FullName
   ,status
   ,salary
   ,if(status = 'Full Time',Salary * 1.1,salary) as NewSalary
   from employees.employees ;
 
 select
   concat(First,' ',Last) as FullName
   ,status
   ,salary
   ,if(status = 'Full Time','Permanent','Temporary') as NewSalary
   from employees.employees ;
   
   
    select
   concat(First,' ',Last) as FullName
   ,status
   ,JobRating
   ,salary
   ,if(status = 'Full Time' and Jobrating = 1, salary * 1.1, salary) as NewSalary
   from employees.employees ;
   
   
   # 1. Hike the salary by 10% for all full time employees and only those contract emp with jobrating 1

   
   select
   concat(First,' ',Last) as FullName
   ,status
   ,JobRating
   ,salary
	,If(status = 'Full Time' or (status ='contract' and jobrating =1), salary * 1.1, salary) as NewSalary
   from employees.employees ;

 
   # 2. Display result in format - Titanic is a hit film which won 11 Oscars

  
SELECT Title,
concat(Title,' is a ',if(BoxOfficeDollars > BudgetDollars, 'hit film ','flop film '),oscarWins,'oscars') as MovieType
FROM movies.film;

   
   # 3. Display Text Title if title contains only text ,else alphanumeric title
   
   select
   Title
   ,if(Title not regexp '[0-9]','Text Title','Alphanumeric Title') as MovieType
   from movies.film ;
   
   
   # 4. Hike salary by 10% for both full time and contract emp with jobrating 1, else same salary
   
   select 
   concat(First, ' ', Last) as FullName
   ,status
   ,jobrating
   ,salary
   ,if( status in ('Full time','Contract') and jobrating =1,Salary*1.1,salary) as NewSalary
   from employees.employees ;
   
   
   
   select
   concat(First,' ',Last) as FullName
   ,if(status = 'Full Time', 'Permanent',if(status = 'contract','Temporary','Terminated')) as EmpType
   from employees.employees;
   
   
      select
   concat(First,' ',Last) as FullName
   ,status
   ,salary
   ,if(status = 'Full Time',Salary *1.1,if(status = 'contract',Salary * 1.05,salary)) as EmpType          # 1.1 = 10% and 1.05 = 5% hike
   from employees.employees;
   
   select
   Title
   ,OscarWins
   ,if(oscarWins =0,'Average Film',IF (oscarWins <5, 'Great Film','Classic Film')) as MovieType
   From movies.film;
   
   