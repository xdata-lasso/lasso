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
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (1, 'AS', 'Computer Science', '101', 'Barton', 1234);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (10, 'Smith', 'John', 'Prof', 'M', 5551, '201', 'Barton');
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('A', 4.0);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('B', 3.0);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'A', 'A', 20, 'M', 1, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'B', 'B', 20, 'F', 1, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (103, 'C', 'C', 20, 'M', 1, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (104, 'D', 'D', 20, 'F', 1, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (105, 'E', 'E', 20, 'M', 1, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (106, 'F', 'F', 20, 'F', 1, 10, 'NYC');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C0', 1, 10, 'ZeroCourse', 3, 'MWF', '9');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C4', 1, 10, 'FourCourse', 3, 'MWF', '10');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C5', 1, 10, 'ZebraCourse', 3, 'MWF', '11');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C6', 1, 10, 'AlphaCourse', 3, 'MWF', '12');
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C4', 101);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C4', 102);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C4', 103);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C4', 104);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C5', 101);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C5', 102);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C5', 103);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C5', 104);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C5', 105);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C6', 101);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C6', 102);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C6', 103);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C6', 104);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C6', 105);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C6', 106);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname FROM (SELECT LHS.cid AS cid, LHS.n AS n, RHS.cname AS cname, RHS.credits AS credits, RHS.instructor AS instructor, RHS.days AS days, RHS.hours AS hours, RHS.dno AS dno FROM (SELECT * FROM (SELECT cid, COUNT(*) AS n FROM enrolled_in GROUP BY cid) WHERE (n >= 5)) AS LHS INNER JOIN course AS RHS ON (LHS.cid = RHS.cid)) ORDER BY cname;

/*
Gold Result:
('AlphaCourse',)
('ZebraCourse',)
*/

-- Prediction Query
SELECT T1.CName FROM COURSE AS T1 JOIN ENROLLED_IN AS T2 ON T1.CID = T2.CID GROUP BY T2.CID HAVING COUNT(*) >= 5;

/*
Prediction Result:
('ZebraCourse',)
('AlphaCourse',)
*/