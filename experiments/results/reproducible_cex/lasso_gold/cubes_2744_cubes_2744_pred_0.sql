-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1001, 'Fowler', 'Jeffrey', 1004, 'wait', 1007, 1010, 'Johnsonland');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1002, 'Johnson', 'Jill', 1013.0, 'offer', 1020.0, 1010, 'East William');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1003, 'Hill', 'Erica', 1022.0, 'begin', 1033.0, 1010, 'New Jamesside');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT advisor AS facid FROM (SELECT advisor, COUNT(*) AS n FROM (SELECT * FROM student AS LHS WHERE NOT EXISTS(SELECT 1 FROM faculty AS RHS WHERE (LHS.fname = RHS.fname AND LHS.lname = RHS.lname))) GROUP BY advisor) WHERE (n >= 2) ORDER BY facid;

/*
Gold Result:
(1010,)
*/

-- Prediction Query
SELECT T1.FacID FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID = T2.advisor GROUP BY T1.FacID HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/