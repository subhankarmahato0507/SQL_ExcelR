Select *
from employees.empcopy ;

Set sql_safe_updates =0;           #use for remove safe update mode

update employees.empcopy
set salary = 100000,
status = 'Full Time'
where Jobrating =1;

select * 
from movies.filmcopy; 
update movies.filmcopy
set BoxofficeDollars =0
where BoxofficeDollars is null;

update employees.empcopy
set salary = case
when status = 'Full Time' then salary * 1.1
when status = 'Contract' then salary * 1.05
else Salary
end;

Update movies.filmcopy
set Title = replace(Title,'star','Diamond');

# 1. Add new column fullname to employees table, update fullname based on first and last

Alter Table employees.employees
add FullName varchar(500) after Last;

update employees.employees
set FullName = concat(First,' ',Last);


# 2. Add new column Email, update Email as First.Last@gmail.com

Alter Table employees.employees
add Email varchar(500) after Fullname;

update employees.employees
set Email = concat(First,'.',Last,'@gmail.com');


# 3. Hike the salary by 10% for jobrating <=2,by 5% for jobrating 3-4,else same salary

update employees.empcopy
set salary =case
when jobrating <=2 then salary *1.1
when jobrating <=4 then salary *1.05
else salary
end;

# 4. Replace war with peace in movie title
update movies.filmcopy
set Title = replace(Title,'war','Peace');


# 5. Update fullname in actor table and Director table

update movies.actor
set FullName =case
when FamilyName is null then FirstName
else concat (FirstName,' ',FamilyName)
end;

update movies.Director
set FullName =case
when FamilyName is null then FirstName
else concat (FirstName,' ',FamilyName)
end;


Delete from employees.empcopy
where status ='Full Time';

Delete from employees.empcopy;                   # delete command only delete the data of table not heading of the column       

Truncate Table movies.filmcopy;                  # in truncate can not use where clause and delete all table  

Drop table movies.filmcopy;                      # Drop command delete the table form the database

Drop table employees.empcopy;     


select Title,
BoxOfficeDollars,
FullName as Director
from movies.film f inner join movies.Director d 
on f.DirectorId = d.DirectorId;

# Title, BoxofficeDollars,OscarWins and Certificate

select Title,
BoxOfficeDollars,
certificate
from movies.film f inner join movies.certificate c
on f.certificateId = c.certificateId;

# Title, BoxofficeDollars,OscarWins and Genre

select Title,
BoxOfficeDollars,
OscarWins,
genre
from movies.film f inner join movies.Genre g
on f.GenreId = g.GenreId;

# Title, BoxofficeDollars,OscarWins and Country

select Title,
BoxOfficeDollars,
OscarWins,
country
from movies.film f inner join movies.Country c
on f.CountryId = c.CountryId;

# Title, BoxofficeDollars,OscarWins and Language

select Title,
BoxOfficeDollars,
OscarWins,
language
from movies.film f inner join movies.language l
on f.languageId = l.languageId;


# Title, BoxofficeDollars,OscarWins and Studio

select Title,
BoxOfficeDollars,
OscarWins,
studio
from movies.film f inner join movies.studio s
on f.studioId = s.studioId;


# Title, ReleaseDate, Director Name, Age of Director when his movie got released

select Title,
ReleaseDate,
FullName,
timestampdiff(year,Dob,ReleaseDate) as Age
from movies.film f inner join movies.director d 
on f.DirectorID = d.DirectorID;



