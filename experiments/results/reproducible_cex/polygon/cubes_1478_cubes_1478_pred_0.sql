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
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (13, '853', '853', 853, '853', 853, 853, '853');
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (12, '853', '853', 853, '853', 853, 853, '853');
INSERT INTO "Faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (14, '853', '853', '853', '853', 853, '853', '853');
INSERT INTO "Department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (16, '853', '853', '853', '853', 853);
INSERT INTO "Department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (15, '853', '853', '853', '853', 853);
INSERT INTO "Member_of" ("dno", "facid", "appt_type") VALUES (16, NULL, '853');
INSERT INTO "Member_of" ("dno", "facid", "appt_type") VALUES (15, 14, '853');
INSERT INTO "Course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('17', 15, 14, '853', 853, '853', '853');
INSERT INTO "Minor_in" ("dno", "stuid") VALUES (15, 12);
INSERT INTO "Minor_in" ("dno", "stuid") VALUES (16, 12);
INSERT INTO "Enrolled_in" ("grade", "cid", "stuid") VALUES ('19', NULL, 12);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('19', NULL);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('20', 853);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT maxgradepoint AS max_gradepoint_, MIN(gradepoint) OVER () AS min_gradepoint_ FROM (SELECT lettergrade, gradepoint, MAX(gradepoint) OVER () AS maxgradepoint FROM gradeconversion) ORDER BY max_gradepoint_, min_gradepoint_ NULLS LAST;

/*
Gold Result:
(853.0, 853.0)
*/

-- Prediction Query
SELECT MAX(gradepoint), MIN(gradepoint) FROM GRADECONVERSION;

/*
Prediction Result:
(853.0, 853.0)
*/