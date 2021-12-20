-- drop database Homework_2;
create database Homework_2;
use Homework_2;
create table Tutor(
	tutorID int primary key,
    certDate date not null,
    status varchar(20) not null
);
create table Student(
	studentID int primary key,
    readStudent decimal(3,1)
);
create table Match_History(
	matchID int primary key,
    tutorID int unique not null,
    studentID int unique not null,
    startDate date not null,
    endDate date,
    foreign key (tutorID) references tutor (tutorID),
    foreign key (studentID) references student (studentID)
);
create table tutor_report(
	matchID int,
    month date,
    hours int not null,
    lessons int not null,
    Primary key (matchID, month),
    Foreign key (matchID) references match_history (matchID)
);
insert into tutor
values ('100',str_to_date('1/05/2008','%m/%d/%Y'),'Active'),
('101',str_to_date('1/05/2008','%m/%d/%Y'),'Temp Stop'),
('102',str_to_date('1/05/2008','%m/%d/%Y'),'Dropped'),
('103',str_to_date('5/22/2008','%m/%d/%Y'),'Active'),
('104',str_to_date('5/22/2008','%m/%d/%Y'),'Active'),
('105',str_to_date('5/22/2008','%m/%d/%Y'),'Temp Stop'),
('106',str_to_date('5/22/2008','%m/%d/%Y'),'Active');

insert into Student
values('3000','2.3'),('3001','5.6'),('3002','1.3'),('3003','3.3'),('3004','2.7'),('3005','4.8'),('3006','7.8'),('3007','1.5');

insert Match_History (matchID,tutorID,studentID,startDate)
values ('1','100','3000',str_to_date('1/10/2008','%m/%d/%Y'));
insert Match_History
values ('2','101','3001',str_to_date('1/15/2008','%m/%d/%Y'),str_to_date('5/15/2008','%m/%d/%Y')),
('3','102','3002',str_to_date('2/10/2008','%m/%d/%Y'),str_to_date('3/01/2008','%m/%d/%Y'));
insert Match_History (matchID,tutorID,studentID,startDate)
values ('4','103','3003',str_to_date('5/28/2008','%m/%d/%Y'));
insert Match_History
values ('5','104','3004',str_to_date('6/01/2008','%m/%d/%Y'),str_to_date('6/15/2008','%m/%d/%Y')),
('6','105','3005',str_to_date('6/01/2008','%m/%d/%Y'),str_to_date('6/28/2008','%m/%d/%Y'));
insert Match_History (matchID,tutorID,studentID,startDate)
values ('7','106','3006',str_to_date('6/01/2008','%m/%d/%Y'));

insert into Tutor_Report
values ('1',str_to_date('6/08','%m/%d'),'8','4'),
('2',str_to_date('6/08','%m/%d'),'8','6'),
('3',str_to_date('6/08','%m/%d'),'4','4'),
('4',str_to_date('7/08','%m/%d'),'10','5'),
('5',str_to_date('7/08','%m/%d'),'4','2');
-- answer for question A
alter table Student
add match_score decimal(3,1);
-- answer for question B
/* how many tutor have a status of 'Temp stop'*/
select count(tutorID) As Temp_stop_number 
from tutor
where status ='Temp Stop';
/* which tutors are active */
select tutorID, certDate, Status
from Tutor
where status ='Active';
/* list tutor information who took certification class in January */
select tutorID, certDate, Status
from Tutor
where CertDate >= '2008/1/1' and CertDate <= '2008/1/31';
-- answer for question C
select count(studentID)
from Match_History
where startDate >= '2008/1/1' and startDate < '2008/6/1';
-- answer for question D
/* list student ranking */
select studentID, ReadStudent
from Student
order by readStudent desc;
/* which student has highest read score */
select studentID as studentID_max,readstudent as read_max
from student
where readstudent in (select max(readstudent) from student);
