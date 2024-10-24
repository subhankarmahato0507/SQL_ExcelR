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
   
   
      select
   concat(First,' ',Last) as FullName
   ,status
   ,salary
   ,if(status = 'Full Time',Salary *1.1,if(status = 'contract' and jobrating =1,Salary * 1.05,salary)) as NewSalary         # 1.1 = 10% and 1.05 = 5% hike
   from employees.employees;
   
   # 1. Display Short film if runtimeminutes <100, avg length film if runtime 100-160, else long film
   select Title
   ,RunTimeMinutes
   ,if(RunTimeMinutes <100,'short Film', if (RunTimeMinutes<160,'Avg Length Film','Long Film')) as MovieType
   from movies.film ;
   
   
   # 2. Hike the salary by 10% for employees with jobrating <=2, by 5% if jobrating 3-4,else same salary
   
   select
      concat( First,' ',Last) as FullName
   ,salary
   ,jobrating
   ,case
   when jobrating <=2 then salary*1.1
   when jobrating <=4 then salary*1.05
   else salary 
   end as NewSalary
   from employees.employees ;
   
   
   # 3. Display text title if title contains only text, alphanumeric title if its contains both text and num else numeric title
   
   select
   Title
   ,case
   when Title not regexp '[0-9]'then'Text Title' 
   when Title regexp '[A-Z]'then'Alphanumeric Title'
   else'Numeric Title'
   end as MovieType
   from movies.film ;
   
   
   # 4. Display classic  blockbuster if boxoffice >1e9 and oscars>0, blockbuster if only boxoffice >1e9 without any oscar, else others
   
   select Title
   ,BoxofficeDollars
   ,OscarWins
   ,case
   when BoxofficeDollars> 1e9 and OscarWins > 0 then 'Classic Blockbuster' 
   when BoxofficeDollars > 1e9 and OscarWins =0 then 'Blockbuster'
   else 'other'
   end as MovieType
   from movies.film ;
   
   
   
   # 5. Hike the salary by 10% for full time emp hired before 2000,by 5% for full time hired after 2000, for others same salary
   
   select
   concat( First,' ',Last) as FullName
   ,status
   ,salary
   ,case	
   when status ='Full Time' and HireDate <'2000-1-1' then salary *1.1 
   when status = 'FullTime' and HireDate > '2000-1-1' then salary*1.05 
   else salary
   end as EmpType
   from employees.employees ;
   
   
   # Case
   # When logical1 is true then Result1
   # When logical2 is true then Result2
   # else Result3
   # end
   
   
   select
   concat(First,' ',Last) as FullName
   ,Status
   ,Case
   when Status = 'FullName' then 'Permanent'
   when Status = 'Contract' then 'Temprorary'
   else 'Terminated'
   end as EmpType
   from employees.employees ;
   
   
   select
   concat(First,' ',Last) as FullName
   ,Status
   ,salary
   ,Case
   when Status = 'FullName' then salary *1.1
   when Status = 'Contract' then salary *1.05
   else salary
   end as NewSalary
   from employees.employees ;
   
   
    select
   concat(First,' ',Last) as FullName
   ,Status
   ,salary
   ,Jobrating
   ,Case
   when Status = 'FullName' then salary *1.1
   when Status = 'Contract' and jobrating =1 then salary *1.05
   else salary
   end as NewSalary
   from employees.employees ;
   
   
   select
   Title
   ,OscarWins
   ,Case
   when OscarWins =0 then 'Average Film'
   when OscarWins <5 then 'Great Film'
   else 'Classic Film'
   end as MovieType
   from movies.film ;
   
   
   # 1. Display Short film if runtimeminutes <100, avg length film if runtimeMinutes 100-160, else long film
 
  select
   Title
   ,RunTimeMinutes
   ,Case
   when RunTimeMinutes<100 then 'Short Film'
   when RunTimeMinutes<160 then 'avg length film'
   else 'Long Film'
   end as MovieType
   from movies.film ;
 
   # 2. Hike the salary by 10% for employees with jobrating <=2, by 5% if jobrating 3-4,else same salary

    select
   concat(First,' ',Last) as FullName
   ,Status
   ,salary
   ,Jobrating
   ,Case
   when Status = 'FullTime' then salary *1.1
   when Status = 'Contract' and jobrating <2 then salary *1.05
   when Status = 'Contract' and jobrating <4 then salary *1.05
   else salary
   end as NewSalary
   from employees.employees ;

   # 3. Display text title if title contains only text, alphanumeric title if its contains both text and num else numeric title
  
  
   select
   Title
   ,Case
   when Title not regexp '[0-9]'then 'Text Title'
   when Title regexp  '[A-Z]' then 'Alphanumeric Title'
   else 'numeric title'
   end as MovieType
   from movies.film ;
   
   
   # 4. Display classic  blockbuster if boxofficeDollar >1e9 and OscarWins>0, blockbuster if only boxofficeDollar >1e9 without any OscarWins, else others


select
   Title
   ,BoxofficeDollars
   ,OscarWins
   ,Case
   when BoxofficeDollars >1e9 and OscarWins>0 then 'classic  blockbuster'
   when BoxofficeDollars >1e9 and OscarWins=0 then 'blockbuster'
   else 'others'
   end as MovieType
   from movies.film ;


   # 5. Hike the salary by 10% for FullTime emp hired before 2000,by 5% for full time hired after 2000, for others same salary
  
   
   select
   concat(First,' ',Last) as FullName
   ,Status
   ,salary
   ,HireDate
   ,Case
   when Status = 'Full Time' and HireDate < '2000-1-1' then salary * 1.1
   when Status = 'Full Time' and HireDate > '2000-1-1'then salary * 1.05
   else salary
   end as NewSalary
   from employees.employees ;
   
   