-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("actid", "activity_name") VALUES (1076, 'Alex Spencer');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1077, 'Chapman', 'Adrian', 'second', 'program', 1078, 'artist', 'drop');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1079, 'Jones', 'Anthony', 1080, 'give', 1081, NULL, 'New Johnfort');
INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1076, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT facid FROM (SELECT LHS.facid AS facid, LHS.actid AS actid, RHS.stuid AS stuid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.city_code AS city_code FROM faculty_participates_in AS LHS INNER JOIN student AS RHS ON (LHS.facid = RHS.advisor)) ORDER BY facid;

/*
Gold Result:
*/

-- Prediction Query
SELECT FacID FROM Faculty_participates_in INTERSECT SELECT advisor FROM Student;

/*
Prediction Result:
(None,)
*/