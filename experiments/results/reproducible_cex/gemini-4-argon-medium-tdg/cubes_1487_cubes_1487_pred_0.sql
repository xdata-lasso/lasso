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
-- Tests basic anti-join, ordering, duplicate DNames (DISTINCT vs ALL), and trap relationships in Student.Major, Member_of, and Course
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (1, 'AS', 'Zoology', '101', 'Sci', 1111);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (2, 'EN', 'CS', '102', 'Eng', 2222);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (3, 'AS', 'Art', '103', 'Arts', 3333);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (4, 'HU', 'Art', '104', 'Arts2', 4444);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (5, 'AS', 'Biology', '105', 'Bio', 5555);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Smith', 'John', 20, 'M', 1, 100, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Doe', 'Jane', 21, 'F', 2, 100, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Lee', 'Bruce', 22, 'M', 3, 100, 'SFO');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (100, 'Prof', 'X', 'Full', 'M', 9999, '201', 'Main');
INSERT INTO Minor_in (DNO, StuID) VALUES (2, 10);
INSERT INTO Minor_in (DNO, StuID) VALUES (2, 20);
INSERT INTO Minor_in (DNO, StuID) VALUES (5, 5);
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (1, 100, 'Primary');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (2, 100, 'Secondary');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C1', 1, 100, 'Intro Zoo', 3, 'MWF', '10:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C2', 2, 100, 'Intro CS', 3, 'MWF', '11:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dname FROM (SELECT * FROM department AS LHS WHERE NOT EXISTS(SELECT 1 FROM minor_in AS RHS WHERE (LHS.dno = RHS.dno))) ORDER BY dname;

/*
Gold Result:
('Art',)
('Art',)
('Zoology',)
*/

-- Prediction Query
SELECT DName FROM DEPARTMENT EXCEPT SELECT T1.DName FROM DEPARTMENT AS T1 JOIN MINOR_IN AS T2 ON T1.DNO = T2.DNO;

/*
Prediction Result:
('Art',)
('Zoology',)
*/