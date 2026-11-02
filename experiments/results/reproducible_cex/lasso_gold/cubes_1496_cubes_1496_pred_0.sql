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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1055, 'movement', 'Sheila Evans', 'purpose', 'politics', 1056);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1065, 'team', 'Philip Cannon', 'career', 'receive', 1066);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1060, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1057, 'Gonzalez', 'Nathaniel', 'color', 'notice', 1058, 'start', 'win');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1067, 'Alvarez', 'Andrea', 'evidence', 'news', 1068, 'turn', 'policy');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('nice', 1055, 1057, 'COMPUTER LITERACY', 1059, 'why', 'a');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('bed', 1060, 1057, 'COMPUTER LITERACY', 1064, 'sign', 'mention');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('land', 1065, 1067, 'COMPUTER LITERACY', 1069, 'development', 'woman');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."facid" AS "facid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."rank" AS "rank", "LHS"."sex" AS "sex", "LHS"."phone" AS "phone", "LHS"."room" AS "room", "LHS"."building" AS "building", "RHS"."cid" AS "cid", "RHS"."cname" AS "cname", "RHS"."credits" AS "credits", "RHS"."days" AS "days", "RHS"."hours" AS "hours", "RHS"."dno" AS "dno" FROM "faculty" AS "LHS" INNER JOIN (SELECT * FROM "course" WHERE ("cname" = 'COMPUTER LITERACY')) AS RHS ON (LHS.facid = RHS.instructor)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Andrea', 'Alvarez')
('Nathaniel', 'Gonzalez')
('Nathaniel', 'Gonzalez')
*/

-- Prediction Query
SELECT T2.Fname, T2.Lname FROM COURSE AS T1 JOIN FACULTY AS T2 ON T1.Instructor = T2.FacID WHERE T1.CName = 'COMPUTER LITERACY';

/*
Prediction Result:
('Nathaniel', 'Gonzalez')
('Nathaniel', 'Gonzalez')
('Andrea', 'Alvarez')
*/