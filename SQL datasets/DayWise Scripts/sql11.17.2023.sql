# SQL - Structured Query Language

# DQL (Data Query Language)

# Select command is used to read data from the table

# Select
# from
# Where
# Group by
# Having
# Order by
# Limit

/* Training Started on 16th November
Today is second class */

# * - All columns in the table
# Ctrl Enter - Runs only command under the keyboard cursor
# Ctrl Shift Enter - Runs all the commands or the selected commands

Select * from movies.film ;

Select 
Title,BoxOfficeDollars,OscarWins,CertificateID
from movies.film ;

# Where clause is used to filter the data

Select
Title,BoxOfficeDollars,OscarWins,CertificateID
from movies.film
Where BoxofficeDollars > 1e9;

# >,<,>=,<=,<>,!=,and,or,between,in,not in,like,not like,regexp,not regexp,is null,is not null
# exists,not exists

Select 
Title,BoxofficeDollars,OscarWins,CertificateID
from movies.film
Where OscarWins >=5;

Select
Title,BoxOfficeDollars,OscarWins,CertificateID
from movies.film
Where BoxofficeDollars > 1e9 and OscarWins >0 and CertificateId = 1;

Select
Title,BoxOfficeDollars,OscarWins,CertificateID
from movies.film
Where CertificateID = 1 or CertificateId = 2;

Select
Title,BoxOfficeDollars,OscarWins,CertificateID
from movies.film
Where CertificateID in (1,2);

Select
Title,BoxOfficeDollars,OscarWins,CertificateID
from movies.film
Where CertificateID not in (1,2);



