drop database exercise_1;
Create database exercise_1;
use exercise_1;
create table student(
	student_id int primary key,
    student_name varchar(20) not null
);
create table registration(
	student_id int not null,
    section_no int not null unique,
    semester varchar(20),
    primary key (student_id, section_no, semester),
    constraint registration_fk foreign key resgistration (student_id) references student (student_id)
);

create table faculty (
	faculty_id int not null unique primary key,
    faculty_name varchar(20) not null
);
create table qualified (
	faculty_id int not null,
    course_id varchar(20) not null unique,
    date_qualified date,
    constraint qualified_pk primary key (faculty_id, course_id),
    constraint qualified_fk foreign key qualified (faculty_id) references faculty (faculty_id)
);
-- set foreign_key_checks=0;
create table course (
	course_id varchar(20) unique not null,
    course_name varchar(20) not null,
    constraint course_pk primary key (course_id),
    constraint course_fk foreign key course (course_id) references qualified (course_id)
);
create table section (
	section_no int not null,
    semester varchar(20) not null,
    course_id varchar(20) not null,
    constraint section_pk primary key (section_no, semester, course_id),
    constraint section_fk1 foreign key section (section_no) references registration (section_no),
    constraint section_fk2 foreign key section (course_id) references course (course_id)
);
