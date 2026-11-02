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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (520, 'place', 'Alec Hickman', 'unit', 'theory', 1083);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1088, 'place', 'Alec Hickman', 'unit', 'theory', 1083);
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1084, 'Roman', 'John', 'effect', 'our', 1085, 'your', 'bar');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1087, 'Roman', 'John', 'effect', 'our', 1085, 'your', 'bar');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1094, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "member_of" ("dno", "facid", "appt_type") VALUES (520, 1084, 'bed');
INSERT INTO "member_of" ("dno", "facid", "appt_type") VALUES (520, 1094, 'bed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM (SELECT LHS.facid AS facid, LHS.dno AS dno, LHS.appt_type AS appt_type, RHS.lname AS lname, RHS.fname AS fname, RHS.rank AS rank, RHS.sex AS sex, RHS.phone AS phone, RHS.room AS room, RHS.building AS building FROM (SELECT * FROM member_of WHERE (dno = 520)) AS LHS LEFT JOIN faculty AS RHS ON (LHS.facid = RHS.facid)) ORDER BY fname, lname NULLS LAST;

/*
Gold Result:
(None, None)
('John', 'Roman')
*/

-- Prediction Query
SELECT T1.Fname, T1.Lname FROM FACULTY AS T1 JOIN MEMBER_OF AS T2 ON T1.FacID = T2.FacID WHERE T2.DNO = 520;

/*
Prediction Result:
('John', 'Roman')
(None, None)
*/