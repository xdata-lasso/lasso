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
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (10, 'EN', 'Computer Science', '101', 'Gates', 1234);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Smith', 'John', 'Professor', 'M', 5551, '201', 'Gates');
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('A+', 4.0);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('A', 3.9);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('A-', 3.85);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('B+', 3.8);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('B', 3.7);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('C', 2.0);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Adams', 'Zack', 22, 'M', 10, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Baker', 'Bob', 20, 'M', 10, 1, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Clark', 'Alice', 25, 'F', 10, 1, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Davis', 'Diana', 21, 'F', 10, 1, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Evans', 'Evan', 19, 'M', 10, 1, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Frank', 'Fiona', 23, 'F', 10, 1, 'MIA');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (10, 1, 'Primary');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('CS101', 10, 1, 'Intro to CS', 4, 'MWF', '10:00');
INSERT INTO Minor_in (DNO, StuID) VALUES (10, 1);
INSERT INTO Minor_in (DNO, StuID) VALUES (10, 2);
INSERT INTO Minor_in (DNO, StuID) VALUES (10, 3);
INSERT INTO Minor_in (DNO, StuID) VALUES (10, 4);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'CS101', 1);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A+', 'CS101', 2);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A-', 'CS101', 3);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B+', 'CS101', 4);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'CS101', 5);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('C', 'CS101', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname" FROM (SELECT "stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code", "cid", "grade", "gradepoint", "grade" AS "lettergrade" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."cid" AS "cid", "LHS"."grade" AS "grade", "RHS"."gradepoint" AS "gradepoint" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."cid" AS "cid", "RHS"."grade" AS "grade" FROM "student" AS "LHS" INNER JOIN "enrolled_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "gradeconversion" AS "RHS" ON ("LHS"."grade" = "RHS"."lettergrade"))) WHERE ("gradepoint" > '3.8') ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT T3.Fname FROM ENROLLED_IN AS T1 CROSS JOIN GRADECONVERSION AS T2 JOIN STUDENT AS T3 ON T1.Grade = T2.lettergrade AND T1.StuID = T3.StuID WHERE T2.gradepoint >= 3.8;

/*
Prediction Result:
('Zack',)
('Bob',)
('Alice',)
('Diana',)
*/