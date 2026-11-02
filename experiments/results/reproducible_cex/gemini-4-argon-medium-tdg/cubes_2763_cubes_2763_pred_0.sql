-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs OUTER JOIN, Faculty table vs Faculty_Participates_in table, and NULL handling.
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Chess'), (2, 'Soccer');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (10, 'Smith', 'John', 'Prof', 'M', 1111, '101A', 'Main'), (20, 'Doe', 'Jane', 'Assoc', 'F', 2222, '102B', 'Main'), (30, 'Brown', 'Bob', 'Asst', 'M', 3333, '103C', 'Sci'), (40, 'White', 'Ann', 'Prof', 'F', 4444, '104D', 'Sci');
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 10), (2, 20), (1, NULL);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (100, 'Adams', 'Amy', 20, 'F', 600, 10, 'NYC'), (200, 'Baker', 'Ben', 21, 'M', 600, 30, 'LAX'), (300, 'Clark', 'Dan', 19, 'M', 500, NULL, 'CHI');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT facid FROM (SELECT LHS.facid AS facid, LHS.actid AS actid, RHS.stuid AS stuid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.city_code AS city_code FROM faculty_participates_in AS LHS INNER JOIN student AS RHS ON (LHS.facid = RHS.advisor)) ORDER BY facid;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT FacID FROM Faculty_participates_in INTERSECT SELECT advisor FROM Student;

/*
Prediction Result:
(None,)
(10,)
*/