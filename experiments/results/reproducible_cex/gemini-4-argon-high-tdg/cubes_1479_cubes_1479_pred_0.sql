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
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (101, 'Turing', 'Alan', 'Professor', 'M', 5551, '10A', 'Gates');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (102, 'Noether', 'Emmy', 'Professor', 'F', 5552, '20B', 'Hilbert');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (10, 101, 'Primary');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (20, 102, 'Primary');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('CS101', 10, 101, 'Intro to CS', 4, 'MWF', '10:00-11:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('MA101', 20, 102, 'Calculus', 3, 'TTH', '09:00-10:30');
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('A', 4.0);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('B', 3.0);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Adams', 'Zack', 21, 'M', 10, 101, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Zimmer', 'Alice', 19, 'F', 20, 102, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Baker', 'Charlie', 22, 'M', 10, 102, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Clark', 'Alice', 20, 'F', 20, 101, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Davis', 'Bob', 18, 'M', 10, 101, 'SFO');
INSERT INTO Minor_in (DNO, StuID) VALUES (20, 1);
INSERT INTO Minor_in (DNO, StuID) VALUES (10, 2);
INSERT INTO Minor_in (DNO, StuID) VALUES (20, 2);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'CS101', 1);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'MA101', 1);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'MA101', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname FROM student ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
('Zack',)
*/

-- Prediction Query
SELECT Fname FROM STUDENT ORDER BY Age DESC, STUDENT.stuid NULLS LAST;

/*
Prediction Result:
('Charlie',)
('Zack',)
('Alice',)
('Alice',)
('Bob',)
*/