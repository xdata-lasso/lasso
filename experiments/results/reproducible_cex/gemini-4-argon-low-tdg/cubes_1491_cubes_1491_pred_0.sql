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
-- DATASET 3
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Adams', 'Amy', 'Asst', 'F', 1234, 'F1', 'B1');
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (1, 'EN', 'BETA', '200', 'B1', 111);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (2, 'EN', 'ALPHA', '300', 'B1', 222);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (3, 'EN', 'ALPHA', '100', 'B1', 333);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (4, 'EN', 'ALPHA', NULL, 'B1', 444);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (5, 'EN', NULL, '050', 'B1', 555);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (6, 'EN', NULL, NULL, 'B1', 666);
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C1', 1, 1, 'INTRODUCTION TO COMPUTER SCIENCE', 3, 'M', '1');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C2', 2, 1, 'INTRODUCTION TO COMPUTER SCIENCE', 3, 'M', '1');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C3', 3, 1, 'INTRODUCTION TO COMPUTER SCIENCE', 3, 'M', '1');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C4', 4, 1, 'INTRODUCTION TO COMPUTER SCIENCE', 3, 'M', '1');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C5', 5, 1, 'INTRODUCTION TO COMPUTER SCIENCE', 3, 'M', '1');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C6', 6, 1, 'INTRODUCTION TO COMPUTER SCIENCE', 3, 'M', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dname", "room" FROM (SELECT "LHS"."dno" AS "dno", "LHS"."division" AS "division", "LHS"."dname" AS "dname", "LHS"."room" AS "room", "LHS"."building" AS "building", "LHS"."dphone" AS "dphone", "RHS"."cid" AS "cid", "RHS"."cname" AS "cname", "RHS"."credits" AS "credits", "RHS"."instructor" AS "instructor", "RHS"."days" AS "days", "RHS"."hours" AS "hours" FROM "department" AS "LHS" INNER JOIN "course" AS "RHS" ON ("LHS"."dno" = "RHS"."dno")) WHERE ("cname" = 'INTRODUCTION TO COMPUTER SCIENCE') ORDER BY dname, "dname" NULLS LAST, "room" NULLS LAST;

/*
Gold Result:
(None, '050')
(None, None)
('ALPHA', '100')
('ALPHA', '300')
('ALPHA', None)
('BETA', '200')
*/

-- Prediction Query
SELECT T2.Dname, T2.Room FROM COURSE AS T1 JOIN DEPARTMENT AS T2 ON T1.DNO = T2.DNO WHERE T1.CName = 'INTRODUCTION TO COMPUTER SCIENCE';

/*
Prediction Result:
('BETA', '200')
('ALPHA', '300')
('ALPHA', '100')
('ALPHA', None)
(None, '050')
(None, None)
*/