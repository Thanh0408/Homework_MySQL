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
    foreign key (FacultyID) references Faculty (FacultyID),
    foreign key (CourseID) references Course (CourseID)
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