CREATE DATABASE SMS;
USE SMS;

CREATE TABLE Batchs(
	BatchId CHAR(6),
    Year INT NOT NULL,
    Time VARCHAR(20),
    PRIMARY KEY(BatchId)
);

CREATE TABLE Students(
    StdId INT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BatchId CHAR(6) NOT NULL,
    Birthday DATETIME,
    Address VARCHAR(100) DEFAULT'Ha Noi',
    Email VARCHAR(50) UNIQUE,
    PRIMARY KEY(StdId),
    CONSTRAINT Students_fk FOREIGN KEY(BatchId) REFERENCES Batchs(BatchId)
);

CREATE TABLE Marks(
	StdId INT NOT NULL,
    Subject VARCHAR(10) NOT NULL,
    Type CHAR(1),
    Mark DECIMAL(4,2),
    CHECK (mark >=0 and mark <= 25),
    CHECK (Type = 'W' OR Type = 'P'),
    -- UNIQUE(Subject, Type),
    PRIMARY KEY(StdId,Subject,Type),
    CONSTRAINT Marks_fk FOREIGN KEY(StdId) REFERENCES Students(StdId)
);

/*-- delete Primary key and foreign key from tables --*/
/*-- delete Foreign keys before delete Primary keys --*/
/*-- begin Marks table --> Students table --> Batchs table --*/
/*-- Look at constraint key name by run script: "SHOW CREATE TABLE Table_name;"--*/
ALTER TABLE Marks DROP FOREIGN KEY marks_fk;
ALTER TABLE Marks DROP PRIMARY KEY;

ALTER TABLE Students DROP FOREIGN KEY students_fk;
ALTER TABLE Students DROP PRIMARY KEY;

ALTER TABLE Batchs DROP PRIMARY KEY;

/*-- set up Frimary key and Foreign key for thoses table with initial requests --*/
/*-- begin: Batchs table --> Students table --> Marks table --*/

ALTER TABLE Batchs ADD PRIMARY KEY(BatchId);

ALTER TABLE Students ADD PRIMARY KEY(StdId);
ALTER TABLE Students ADD CONSTRAINT Students_fk FOREIGN KEY(BatchId) REFERENCES Batchs(BatchId);

ALTER TABLE Marks ADD PRIMARY KEY(StdId,Subject,Type);
ALTER TABLE Marks ADD CONSTRAINT Marks_fk FOREIGN KEY(StdId) REFERENCES Students(StdId);

/*-- add new columns for Batchs table --*/
/*-- have a warning when run data type TINYINT(1) --*/
ALTER TABLE Batchs ADD ClassRoom TINYINT(1);
ALTER TABLE Batchs ADD LabRoom TINYINT(1);

/*-- add information in those columns --*/
/*-- Batchs Table --*/
USE SMS;
INSERT INTO Batchs (BatchID , Year , Time , ClassRoom , LabRoom)
VALUES ('C0809I', '2008' , '13h30-17h30' , '1' , '1'),
('C0812I', '2008' , '13h30-17h30' , '2' , '2'),
('C0909L', '2009' , '17h30-19h30' , '2' , '2'),
('T0906G', '2009' , '13h30-17h30' , '1' , '1'),
('T0908I', '2009' , '7h30-11h30' , '3' , '3'),
('T0909G', '2009' , '13h30-17h30' , '2' , '2');

/*-- Students Table --*/

SET foreign_key_checks = 0;
INSERT INTO Students (StdID , FirstName , LastName , BatchID , Birthday , Address , Email)
Values ('1' , 'Nguyen Van' , 'A' , 'C0909L', STR_TO_DATE('18/02/2019 12:00:00','%d/%m/%Y %H:%i:%s') , 'Ha Noi' , 'anv@yahoo.com'),
('2' , 'Tran Thi' , 'B' , 'T0909G', STR_TO_DATE('18/02/2019 12:00:00','%d/%m/%Y %H:%i:%s') , 'Hai Phong' , 'btt@yahoo.com'),
('3' , 'Nguyen Van' , 'C' , 'T0909G', STR_TO_DATE('18/02/2019 12:00:00','%d/%m/%Y %H:%i:%s') , 'Nam Dinh' , 'cnv@yahoo.com'),
('4' , 'Le Thi' , 'D' , 'C0908I', STR_TO_DATE('18/02/2019 12:00:00','%d/%m/%Y %H:%i:%s') , 'Hoa Binh' , 'dlt@yahoo.com'),
('5' , 'Tran Thi' , 'E' , 'T0906G', STR_TO_DATE('18/02/2019 12:00:00','%d/%m/%Y %H:%i:%s') , 'Ha Noi' , 'etv@yahoo.com');


/*-- Marks Table --*/
INSERT INTO Marks (StdID , Subject , Type , Mark)
VALUES ('1' , 'CF' , 'W' , '12.50'),
('1' , 'C' , 'W' , '15.25'),
('1' , 'C' , 'P' , '14.00'),
('2' , 'CF' , 'W' , '14.50'),
('2' , 'C' , 'P' , '16.50'),
('3' , 'C' , 'W' , '12.50'),
('3' , 'C' , 'P' , '12.50'),
('4' , 'CF' , 'W' , '13.50'),
('4' , 'C' , 'P' , '15.50'),
('5' , 'C' , 'W' , '12.50'),
('5' , 'C' , 'P' , '17.50');

SET foreign_key_checks = 1;

