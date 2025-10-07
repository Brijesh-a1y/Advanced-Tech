create database StudentsDetails

use StudentsDetails


create table Student(
	id int primary key,
	name varchar(25),
	mark1 float,
	mark2 float,
	mark3 float,
	total float,
	result varchar(4)
)

--query for all students
select * from Student

alter table Student
add dob date

alter table Student
drop constraint id

insert into Student(id,name,mark1,mark2,mark3,total,result,dob) values
	(101,'Ram',30,30,30,90,'Pass','1999-03-03');

	
insert into Student(id,name,mark1,mark2,mark3,total,result,dob) values
	(102,'Varun',40,40,40,120,'Pass','1998-06-07'),
	(103,'Kira',20,20,20,60,'Fail','1998-04-01');


--query for marks greater than 35
select *
from Student
where mark1>35 and mark2>35 and mark3>35;

--query for Date of birth between two dates
select *
from Student
where dob between '1998-04-01' and '1999-03-03'

-- marks less then 35
select *
from Student 
where mark1<35 or mark2<35 or mark3<35

-- name search
select *
from Student
where name='Kira'

-- more than one name search
select *
from Student
where name='Kira' or name = 'Varun'

-- using IN operator
select *
from Student
where name in ('Kira','Varun')

--month function
select * 
from Student 
where month(dob)='04'

-- day function
select * 
from Student 
where day(dob)='01'

-- year function
select * 
from Student 
where year(dob)='1998'

-- month between 03 and 07
select * 
from Student 
where month(dob) between 03 and 07;

--dateadd function
-- dateadd function it adds 2 month in your dob
select DATEADD(Month,2,dob) as 'mydate'
from Student

-- it adds 2 days in your dob
select DATEADD(day,2,dob) as 'mydate'
from Student

-- it adds 1 year in your dob
select DATEADD(year,1,dob) as 'mydate'
from Student


--datediff function it gives difference b/w two dates
-- year difference b/w two dates
select DATEDIFF(YEAR,'1998-06-07','1998-04-01');

-- month difference b/w two dates
select DATEDIFF(MONTH,'1998-04-01','1998-06-07');

-- day difference b/w two dates
select DATEDIFF(DAY,'1998-04-01','1998-06-07');


select GETDATE()
select cast(GETDATE() as date)
SELECT DATEPART(DAY, GETDATE()) AS 'Day';

select isdate(getDate())


select UPPER(name) from Student
select lower(name) from Student
select left(name,2) from Student
select right(name,2) from Student
select substring(name,1,3) from Student
select len(name) from Student

select *
from Student
where name like 'V%'

select *
from Student
where name like 'V_'


select *
from Student
where name like 'R%m'

select *
from Student
where name like '_a%'

select len('    ramesh'), ltrim('    ramesh') as 'Commando Name'
select len('    ramesh    '), rtrim('    ramesh    ') as 'Commando Name'
select trim('    ramesh    ')

select concat('my name is ','Xyz ','My address ','this is correct')

select concat('Swati has score ',(mark1+mark2+mark3)) as scoreTable
from Student;


select DIFFERENCE('name','names')
select replicate('Indian Army ',3)
select right(replicate(3,3),2)-33

select REPLACE('this is my sentence','sentence','word')

select str(4.6677,5,4)
select str(floatExpression,totalLength,totalDecimalPlace)

SELECT STR(123.456, 7, 2);
-- Result: '  123.46' (Length 7, 2 decimal places, right-justified with leading spaces)

SELECT STR(123.556);
-- Result: '124' (Default length and decimal places and rounded it)

SELECT STR(123.456, 5);
-- Result: '  123' (Length 5, no decimal places, rounded)

    SELECT FORMAT(1234.56, 'C', 'en-US') AS FormattedCurrency;
    -- Output: $1,234.56

	select GETDATE()

	    SELECT FORMAT(GETDATE(), 'dd-MM-yyyy') AS FormattedDate;
    -- Output (example): 07-10-2025

	select *
	from Student
	where name like '%[^0-1]%'

SELECT ABS(-10.5); -- Result: 10.5
SELECT ROUND(123.456, 3); -- Result: 123.46
SELECT FLOOR(10.9); -- Result: 10
SELECT CEILING(10.1); -- Result: 11
SELECT SQRT(25); -- Result: 5.0
SELECT POWER(2, 3); -- Result: 8
SELECT SIGN(-5); -- Result: -1
SELECT SIGN(5); -- Result: 1
SELECT SIGN(0); -- Result: 0
select rand(); -- Returns a pseudo-random float value between 0 and 1

Aggregte function -> sum ,avg,max,min,count;



select convert(varchar,getDate())
select GETDATE()
SELECT CONVERT(VARCHAR(50), GETDATE(), 103); -- Outputs date in dd/mm/yyyy format
SELECT CONVERT(INT, '12345');
SELECT CONVERT(VARCHAR(20), 123.45, 1); -- Style 2 for currency format

create table DummyStudent(
	id int primary key,
	name varchar(25),
	result varchar(4)
)
drop table DummyStudent
select * from DummyStudent

insert into DummyStudent(id,name,result) 
	(select id,name,result 
	from Student)

--not work in mssql
create table newStudent as select * from DummyStudent


--work in mssql
SELECT *
INTO newStudent
FROM DummyStudent;



select * from newStudent

alter table Student
add average float

select * from Student

alter table Student
drop column result


alter table Student
add result varchar(4)

select * from Student

update Student
set result = 'Pass'
where ((mark1+mark2+mark3)/3)>35


update Student
set result = 'Fail'
where ((mark1+mark2+mark3)/3)<35


update Student
set average = ((mark1+mark2+mark3)/3)

select * from Student

select *
from Student
order by total desc

select TOP 1 *
from Student
order by total desc


select * 
from Student

select count(*) as 'Pass student'
from Student
where result='Pass'
group by result;





select * from Student

select * 
from Student
group by result


unique check default

alter table Student
add salary varchar(25) constraint SalaryConstraints check(salary>4000)

alter table Student
add department varchar(25) constraint DepartmentConstraints default 'CSE'

alter table Student
drop column department


alter table Student
drop constraint DepartmentConstraints

--Error
alter table Student
add mob varchar(25) constraint MobileConstraints not null

select * from sys.check_constraints
select * from sys.all_columns;
select * from sys.objects
select * from sys.tables
select * from sys.databases
select * from sys.columns