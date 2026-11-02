-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard aggregation, an activity with 0 faculty participations (detects reversed LEFT JOIN), and decoy rows in Participates_in (detects wrong table usage).
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Debate');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Chess');
INSERT INTO Activity (actid, activity_name) VALUES (3, 'UnassignedActivity');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (10, 'Smith', 'John', 'Prof', 'M', 1234, '101', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (20, 'Doe', 'Jane', 'Assoc', 'F', 5678, '102', 'Main');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (100, 'Brown', 'Charlie', 20, 'M', 1, 10, 'NYC');
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 10);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 20);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 10);
INSERT INTO Participates_in (actid, stuid) VALUES (3, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_name, n AS count___ FROM (SELECT LHS.actid AS actid, LHS.n AS n, RHS.activity_name AS activity_name FROM (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid) AS LHS LEFT JOIN activity AS RHS ON (LHS.actid = RHS.actid)) ORDER BY activity_name, count___ NULLS LAST;

/*
Gold Result:
('Chess', 1)
('Debate', 2)
*/

-- Prediction Query
SELECT T1.activity_name, COUNT(*) FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID = T2.actID GROUP BY T1.actID;

/*
Prediction Result:
('Debate', 2)
('Chess', 1)
*/