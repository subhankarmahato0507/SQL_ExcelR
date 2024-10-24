# 1. Display the list of films which start with c or h but ends with od

select Title
from movies.film
where Title like 'c%od' or Title like 'h%od' ;

select Title
from movies.film
where (Title like 'c%' or Title like 'h%') and Title like '%od';

# 2. Display the list of film which start and end with execute

select Title 
from movies.film
where Title like 'E%E';

# 3. Display the list of films which does not contain star, king, die and has won oscars
select Title, OscarWins
from movies.film
where Title  =! ('%star%' and '%king%' and '%die%') and oscarwins > 0 ; # wrong hai just trying

select Title, OscarWins
from movies.film
where Title not like '%Star%' and Title not like '%king%' and Title not like '%Die%' and OscarWins>0;


# 4. Display the list of films which contains exactly four characters in title
 select Title
 from movies.film
 where Title like '____' ;
 
 select Title
 from movies.film
 where length(Title)= 4 ;
 
 # 5. Display the list of films which is second part of that movies series
  select *
  from movies.film
  where Title like '% 2 %' or (Title like '% II %' and Title not like '% III %') ;
  
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
 where substring(title,1,2) regexp '^[0-9]+$';                 # SUBSTRING(string, start, length)
 
 
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
  
  
  