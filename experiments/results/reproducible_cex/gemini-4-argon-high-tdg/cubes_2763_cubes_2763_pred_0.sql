-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Robotics');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (7, 'Ross', 'Ken', 'Professor', 'M', 7777, '7R', 'Tech');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'NullAdv', 'One', 20, 'M', 10, NULL, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, NULL, NULL, NULL, NULL, NULL, 7, NULL);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, NULL);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (NULL, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT facid FROM (SELECT LHS.facid AS facid, LHS.actid AS actid, RHS.stuid AS stuid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.city_code AS city_code FROM faculty_participates_in AS LHS INNER JOIN student AS RHS ON (LHS.facid = RHS.advisor)) ORDER BY facid;

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT FacID FROM Faculty_participates_in INTERSECT SELECT advisor FROM Student;

/*
Prediction Result:
(None,)
(7,)
*/