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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1158, 'traditional', 'Hunter Fleming', 'reflect', 'board', 1159);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1168, 'simple', 'Debra Cobb', 'box', 'idea', 1169);
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1160, 'Gomez', 'Anita', 'two', 'investment', 1161, 'pressure', 'so');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1170, 'Brennan', 'Michele', 'doctor', 'decision', 1171, 'technology', 'why');
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('clear', 1162.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('magazine', 1163.5);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1163, 'Frost', 'Michael', 1164, 'commercial', 1165, 1166, 'East Andrew');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1173, 'Hicks', 'Joel', 1165, 'try', 1166, 1167, 'South Angel');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('since', 1158, 1160, 'Rachel Jenkins', 1167, 'relationship', 'treat');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('data', 1168, 1170, 'Donald Jones', 1177, 'spring', 'family');
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('clear', 'since', 1163);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('magazine', 'data', 1173);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, gradepoint FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.cid AS cid, RHS.grade AS grade, RHS.gradepoint AS gradepoint, RHS.lettergrade AS lettergrade FROM student AS LHS INNER JOIN (SELECT stuid, cid, grade, gradepoint, grade AS lettergrade FROM (SELECT LHS.stuid AS stuid, LHS.cid AS cid, LHS.grade AS grade, RHS.gradepoint AS gradepoint FROM enrolled_in AS LHS INNER JOIN gradeconversion AS RHS ON (LHS.grade = RHS.lettergrade))) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY fname, lname NULLS LAST, gradepoint NULLS LAST;

/*
Gold Result:
('Joel', 'Hicks', 1163.5)
('Michael', 'Frost', 1162.5)
*/

-- Prediction Query
SELECT T3.Fname, T3.LName, T2.gradepoint FROM ENROLLED_IN AS T1 CROSS JOIN GRADECONVERSION AS T2 JOIN STUDENT AS T3 ON T1.Grade = T2.lettergrade AND T1.StuID = T3.StuID;

/*
Prediction Result:
('Michael', 'Frost', 1162.5)
('Joel', 'Hicks', 1163.5)
*/