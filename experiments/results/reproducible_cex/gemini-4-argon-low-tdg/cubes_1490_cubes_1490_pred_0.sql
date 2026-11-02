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
-- DATASET 2
-- Tests ORDER BY fname, lname NULLS LAST, tie-breaking, and NULL handling in sorting columns.
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (140, 'EN', 'Computer Science', '101', 'Gates', 1111);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Zeta', 'Aaron', 20, 'M', 100, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Alpha', 'Aaron', 21, 'M', 100, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, NULL, 'Aaron', 22, 'F', 100, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Beta', 'Zack', 19, 'M', 100, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Gamma', NULL, 23, 'F', 100, 1, 'NYC');
INSERT INTO Minor_in (DNO, StuID) VALUES (140, 1);
INSERT INTO Minor_in (DNO, StuID) VALUES (140, 2);
INSERT INTO Minor_in (DNO, StuID) VALUES (140, 3);
INSERT INTO Minor_in (DNO, StuID) VALUES (140, 4);
INSERT INTO Minor_in (DNO, StuID) VALUES (140, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.dno AS dno FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.dno AS dno FROM student AS LHS INNER JOIN minor_in AS RHS ON (LHS.stuid = RHS.stuid)) AS LHS INNER JOIN (SELECT * FROM minor_in WHERE (dno = 140)) AS RHS ON (LHS.stuid = RHS.stuid AND LHS.dno = RHS.dno)) ORDER BY fname, lname NULLS LAST;

/*
Gold Result:
(None, 'Gamma')
('Aaron', 'Alpha')
('Aaron', 'Zeta')
('Aaron', None)
('Zack', 'Beta')
*/

-- Prediction Query
SELECT T2.Fname, T2.Lname FROM MINOR_IN AS T1 JOIN STUDENT AS T2 ON T1.StuID = T2.StuID WHERE T1.DNO = 140;

/*
Prediction Result:
('Aaron', 'Zeta')
('Aaron', 'Alpha')
('Aaron', None)
('Zack', 'Beta')
(None, 'Gamma')
*/