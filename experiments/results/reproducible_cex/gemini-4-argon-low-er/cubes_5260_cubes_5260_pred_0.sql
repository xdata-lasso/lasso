-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Basketball');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (2, 'Soccer');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Smith', 'John', 'Prof', 'M', 1234, '101', 'Main');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 1);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT activity_name FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, LHS.facid AS facid, LHS.n AS n FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, LHS.facid AS facid, RHS.n AS n FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, RHS.facid AS facid FROM activity AS LHS INNER JOIN faculty_participates_in AS RHS ON (LHS.actid = RHS.actid)) AS LHS INNER JOIN (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid) AS RHS ON (LHS.actid = RHS.actid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY activity_name;

/*
Gold Result:
('Basketball',)
('Soccer',)
*/

-- Prediction Query
SELECT T1.activity_name FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID = T2.actID GROUP BY T1.actID ORDER BY COUNT(*) DESC, T1.activity_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Basketball',)
*/