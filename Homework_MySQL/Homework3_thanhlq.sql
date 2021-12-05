drop database exercise_1;
create database exercise_1;
use exercise_1;
create table  EmployeeInfo(
	empID int Primary key,
    empFname varchar(10) not null,
    empLname varchar(10) not null,
    department varchar(10) not null,
    project varchar(10) not null,
    address varchar(20) not null,
    dob date not null,
    gender varchar(1) check(gender = "M" or gender = "F")
);
create table EmployeePosition (
	empID int,
    empPosition varchar(20) not null,
    dateOfJoining time not null,
    salary int not null,
    primary key(empID, empPosition),
    Foreign key (empID) references EmployeeInfo(empID)
);

insert into EmployeeInfo
values ('1', 'Sanjay', 'Mehra', 'HR', 'P1', 'Hyderabad(HYD)', '1976/12/01', 'M'),
('2', 'Ananya', 'Mishra', 'Admin', 'P2', 'Delhi(DEL)', '1968/05/02', 'F'),
('3', 'Rohan', 'Diwan', 'Account', 'P3', 'Mumbai(BOM)','1980/01/01', 'M'),
('4', 'Sonia', 'Kulkarni', 'HR', 'P1', 'Hyderabad(HYD)','1992/05/02', 'F'),
('5', 'Ankit', 'Kapoor', 'Admin', 'P2', 'Delhi(DEL)', '1994/07/03', 'M');

insert into EmployeePosition 
values ('1', 'Manager', STR_TO_DATE('01/05/2019','%d/%m/%Y'), '500000'),
('2', 'Executive', STR_TO_DATE('02/05/2019','%d/%m/%Y'), '75000'),
('3', 'Manager', STR_TO_DATE('01/05/2019','%d/%m/%Y'), '90000'),
('2', 'Lead', STR_TO_DATE('02/05/2019','%d/%m/%Y'), '85000'),
('1', 'Executive', STR_TO_DATE('01/05/2019','%d/%m/%Y'), '300000');
-- 1.
select count(department)
from EmployeeInfo
where department = 'HR';

-- 2
select substring(empLname,1,4)
from employeeInfo;

-- 3.
select *
from EmployeeInfo
where empID in (select empID from EmployeePosition where (salary >= 50000 and salary <= 100000));

-- 4. have to fix 
select count(dob), gender
from EmployeeInfo
where dob between '1970-05-02' and '1975-12-31'
-- where (dob >'1970-05-02' and dob < '1975-12-31')
group by gender;

-- 5
select * 
from EmployeeInfo
order by empLname DESC, Department ASC;

-- 6
select *
from EmployeeInfo
where empLname like '%a' and length(empLname) = 5;

-- 7
select *
from EmployeeInfo
where empFname != 'Sanjay' and empFname != 'Sonia';

-- 8
select *
from EmployeeInfo
where address = 'Delhi(DEL)';

-- 9
select empID, empFname, empLname, department, address, dob, gender
from EmployeeInfo
where empID in ( select empID from EmployeePosition where empPosition = 'manager');

-- 10
select count(department), department
from EmployeeInfo
group by department
order by count(department) ASC;

-- 11
select min(Salary), max(Salary)
from employeePosition;

-- 12
SELECT empFname, COUNT(empFname),
	   empLname, count(empLname),
       address, count(address),
	   dob, count(dob),
       gender, count(gender)
FROM employeeInfo 
GROUP BY empFname, empLname, address, dob, gender 
HAVING count(empFname) > 1 and
	   count(empLname) >1 and
       count(address) > 1 and
       count(dob) > 1 and
       count(gender) >1;
       
-- 13
SELECT a.empId, a.empFname, a.empLname, a.department
FROM employeeInfo as a
INNER JOIN employeeInfo as b
on a.department = b.department
and a.empID != b.empID;

-- 14
SELECT department, count(department) c
FROM employeeInfo 
GROUP BY department HAVING c < 2;

-- 15
select empID, sum(salary)
from employeePosition
group by empId
