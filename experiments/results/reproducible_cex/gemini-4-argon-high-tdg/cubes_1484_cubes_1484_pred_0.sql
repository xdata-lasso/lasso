-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

CREATE TABLE "Department" ("DNO" INTEGER PRIMARY KEY, "Division" TEXT(2), "DName" TEXT(25), "Room" TEXT(5), "Building" TEXT(13), "DPhone" INTEGER);

CREATE TABLE "Member_of" ("DNO" INTEGER, "FacID" INTEGER, "Appt_Type" TEXT(15), FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Course" ("CID" TEXT(7) PRIMARY KEY, "DNO" INTEGER, "Instructor" INTEGER, "CName" TEXT(40), "Credits" INTEGER, "Days" TEXT(5), "Hours" TEXT(11), FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("Instructor") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Minor_in" ("DNO" INTEGER, "StuID" INTEGER, FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Enrolled_in" ("Grade" TEXT(2), "CID" TEXT(7), "StuID" INTEGER, FOREIGN KEY ("Grade") REFERENCES "Gradeconversion" ("lettergrade"), FOREIGN KEY ("CID") REFERENCES "Course" ("CID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Gradeconversion" ("lettergrade" TEXT(2) PRIMARY KEY, "gradepoint" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (10, 'EN', 'Computer Science', '101', 'Gates', 1111);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (20, 'AS', 'Mathematics', '202', 'Hilbert', 2222);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (30, 'AS', 'Biology', '303', 'Darwin', 3333);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Turing', 'Alan', 'Professor', 'M', 5001, '10A', 'Gates');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Noether', 'Emmy', 'Professor', 'F', 5002, '20B', 'Hilbert');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, 'Mendel', 'Gregor', 'Associate', 'M', 5003, '30C', 'Darwin');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'Alice', 20, 'F', 10, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Jones', 'Bob', 22, 'M', 20, 2, 'BOS');
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('A', 4.0);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('B', 3.0);
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C200', 20, 2, 'Databases', 4, 'TTh', '10:00-11:30');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C300', 10, 3, 'Algorithms', 3, 'MWF', '09:00-10:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C100', 30, 1, 'Zoology', 1, 'F', '13:00-14:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C050', 10, 1, 'Algorithms', 2, 'MW', '11:00-12:00');
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C200', 1001);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C200', 1002);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C300', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname FROM course ORDER BY cname, course.cid NULLS LAST;

/*
Gold Result:
('Algorithms',)
('Algorithms',)
('Databases',)
('Zoology',)
*/

-- Prediction Query
SELECT CName FROM COURSE ORDER BY Credits, COURSE.cid NULLS LAST;

/*
Prediction Result:
('Zoology',)
('Algorithms',)
('Algorithms',)
('Databases',)
*/