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
-- General comprehensive dataset:
-- Tests anti-join (NOT EXISTS), ORDER BY DName (reverse to DNO), duplicate DName across different DNOs (tests DISTINCT vs ALL),
-- confusion between Student.Major / Course.DNO / Member_of.DNO and Minor_in.DNO, and multiple minors per department.
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (10, 'EN', 'Zoology', '101', 'Sci', 1111);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (20, 'AS', 'Anthropology', '102', 'Arts', 2222);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (30, 'AS', 'Anthropology', '103', 'Arts', 3333);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (40, 'EN', 'Computer Sci', '104', 'Eng', 4444);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (50, 'AS', 'Biology', '105', 'Sci', 5555);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 10, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 40, 100, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (50, 'Roe', 'Richard', 22, 'M', 20, 100, 'CHI');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (100, 'Brown', 'Bob', 'Prof', 'M', 9999, '201', 'Sci');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (40, 100, 'Primary');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (10, 100, 'Secondary');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS101', 40, 100, 'Intro CS', 3, 'MWF', '10am');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('ZOO101', 10, 100, 'Intro Zoo', 3, 'TTH', '2pm');
INSERT INTO "Minor_in" ("DNO", "StuID") VALUES (40, 1);
INSERT INTO "Minor_in" ("DNO", "StuID") VALUES (40, 2);
INSERT INTO "Minor_in" ("DNO", "StuID") VALUES (50, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dname FROM (SELECT * FROM department AS LHS WHERE NOT EXISTS(SELECT 1 FROM minor_in AS RHS WHERE (LHS.dno = RHS.dno))) ORDER BY dname;

/*
Gold Result:
('Anthropology',)
('Anthropology',)
('Zoology',)
*/

-- Prediction Query
SELECT DName FROM DEPARTMENT EXCEPT SELECT T1.DName FROM DEPARTMENT AS T1 JOIN MINOR_IN AS T2 ON T1.DNO = T2.DNO;

/*
Prediction Result:
('Anthropology',)
('Zoology',)
*/