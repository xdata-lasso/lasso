-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Smith', 'John', 'Prof', 'M', 1234, '101', 'Main');
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Soccer');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Archery');
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 1);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 1);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_name, n AS count___ FROM (SELECT LHS.actid AS actid, LHS.n AS n, RHS.activity_name AS activity_name FROM (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid) AS LHS LEFT JOIN activity AS RHS ON (LHS.actid = RHS.actid)) ORDER BY activity_name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Archery', 1)
('Soccer', 1)
*/

-- Prediction Query
SELECT T1.activity_name, COUNT(*) FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID = T2.actID GROUP BY T1.actID;

/*
Prediction Result:
('Soccer', 1)
('Archery', 1)
*/