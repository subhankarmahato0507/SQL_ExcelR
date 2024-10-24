# creating functions to run fast

select
Title,ReleaseDate,
concat(timestampdiff(Year,ReleaseDate,curdate()), ' Years ', timestampdiff(Month,ReleaseDate,curdate()) mod 12, ' Months' ) as Age
from movies.film;


select
Title,ReleaseDate,
timestampdiff(Year,ReleaseDate,curdate()) as Year,
timestampdiff(Month,ReleaseDate,curdate()) mod 12 as Months
from movies.film;


select
Title,ReleaseDate,
fnAge(ReleaseDate) as Age
from movies.film;

select
concat(FirstName, ' ', FamilyName)as FullName,
Dob,
fnAge(Dob) as Age
from movies.actor;

select
concat(FirstName, ' ', FamilyName)as FullName,
Dob,
fnAge(Dob) as Age
from movies.director;


# Friday, 1st December 2023

select title,ReleaseDate,
concat(DayName(ReleaseDate), ',', Day(ReleaseDate),
case 
when Day(ReleaseDate) in (1,21,31) then'st'
when Day(ReleaseDate) in (2,22) then'nd'
when Day(ReleaseDate) in (3,23) then'rd'
else 'th'
end, ' ', MonthName(ReleaseDate), ' ', year(ReleaseDate)) as ldformat
from movies.film ;

select title,ReleaseDate,
ldformat(ReleaseDate) as longDate
from movies.film ;

select
concat(FirstName, ' ', FamilyName)as FullName,
Dob,
ldformat(Dob) as longDate
from movies.actor;

select
concat(FirstName, ' ', FamilyName)as FullName,
Dob,
ldformat(Dob) as longDate
from movies.director;


