drop database registration;
create database registration;
use registration;
create table Student (
	StudentID int,
    StudentName varchar(20),
    primary key (StudentID)
);
create table Faculty (
	FacultyID int,
    FacultyName varchar(20) unique,
    PRIMARY KEY (FacultyID)
);
create table Course (
	CourseID varchar(10),
    CourseName varchar(30) unique,
    PRIMARY KEY (CourseID)
);
create table Qualified (
	FacultyID int,
    CourseID varchar(10),
    DateQualified date not null,
    primary key (FacultyID, CourseID),
    foreign key (FacultyID) references Faculty (FacultyID)
		on delete restrict
        on update cascade,
    foreign key (CourseID) references Course (CourseID)
		on delete restrict
        on update cascade 
);
create table Section (
	SectionNo int,
    Semester varchar(10),
    CourseID varchar(10),
    primary key (SectionNo, Semester, CourseID),
    foreign key (CourseID) references Course (CourseID)
);
create table Registration (
	StudentID int,
    SectionNo int,
    Semester varchar(10),
    primary key (StudentID, SectionNo, Semester),
    foreign key (StudentID) references Student (StudentID),
    foreign key (SectionNo) references Section (SectionNo)
);
SET FOREIGN_KEY_CHECKS=0;
insert into student 
values ('38214', 'Letersky'), ('54907', 'Alvater'), ('66324', 'Aiken'), ('70542', 'Marra');
insert into Faculty
values ('2143','Birkin'),('3467','Berndt'),('4756','Collins');
insert into Course
values ('ISM 3113','Syst Analysis'),('ISM3112','Syst Design'),('ISM 4212','Database'),('ISM 4930','Networking');
insert into Qualified
values ('2143','ISM 3112',str_to_date('9/1998','%m/%Y')),('2143','ISM 3113',str_to_date('9/1988','%m/%Y')),('3467','ISM 4212',str_to_date('9/1995','%m/%Y')),
('3467','ISM 4930',str_to_date('9/1996','%m/%Y')),('4756','ISM 3113',str_to_date('9/1991','%m/%Y')),('4756','ISM 3112',str_to_date('9/1991','%m/%Y'));
insert into Section
values ('2712','I-2008','ISM 3113'),('2713','I-2008','ISM 3113'),
('2714','I-2008','ISM 4212'),('2715','I-2008','ISM 4930');
insert into registration
values ('38214','2714','I-2008'),('54907','2714','I-2008'),
('54907','2715','I-2008'),('66324','2713','I-2008');
SET FOREIGN_KEY_CHECKS=1;
-- answer for question A
select CourseID, CourseName 
from Course
where courseID like 'ISM%';
-- answer for question B
select FacultyID, CourseID, DateQualified
from Qualified
where FacultyID in (select FacultyID from faculty where facultyName = 'Berndt');
-- answer for question C
select FacultyName
from Faculty
where FacultyID In (select FacultyID from qualified where courseID = 'ISM 3113');
-- answer for question D
select FacultyName
from Faculty
where FacultyID In (select FacultyID from qualified where courseID = 'ISM 3113')
and FacultyID not in(select FacultyID from qualified where courseID = 'ISM 4930');
-- answer for question execute
select count(studentID) 
from registration
where sectionNo = '2714' and Semester = 'I-2008';

select count(studentID) 
from registration
where Semester = 'I-2008'
and sectionNo in (select sectionNo from Section where CourseID = 'ISM 3113'); 
-- answer for question F
select studentID, studentName
from Student
Where StudentID not in (select StudentID from registration where semester = 'I-2008');