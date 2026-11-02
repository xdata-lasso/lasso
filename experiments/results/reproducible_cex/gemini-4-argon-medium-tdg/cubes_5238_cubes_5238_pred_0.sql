-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Activity (actid, activity_name) VALUES (101, 'Chess'), (102, 'Debate'), (103, 'Music');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Smith', 'Alice', 'Prof', 'F', 1111, '101', 'B1'), (2, 'Smith', 'Alice', 'Assoc', 'F', 2222, '102', 'B1'), (3, 'Smith', 'Alice', 'Asst', 'F', 3333, '103', 'B1'), (4, 'Brown', 'Alice', 'Prof', 'F', 4444, '104', 'B1');
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (101, 1), (102, 1), (101, 2), (101, 3), (102, 3), (101, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, n AS count___, facid FROM (SELECT LHS.facid AS facid, LHS.lname AS lname, LHS.fname AS fname, LHS.rank AS rank, LHS.sex AS sex, LHS.phone AS phone, LHS.room AS room, LHS.building AS building, RHS.n AS n FROM faculty AS LHS INNER JOIN (SELECT facid, COUNT(*) AS n FROM faculty_participates_in GROUP BY facid) AS RHS ON (LHS.facid = RHS.facid)) ORDER BY fname, lname NULLS LAST, count___ NULLS LAST, facid NULLS LAST;

/*
Gold Result:
('Alice', 'Brown', 1, 4)
('Alice', 'Smith', 1, 2)
('Alice', 'Smith', 2, 1)
('Alice', 'Smith', 2, 3)
*/

-- Prediction Query
SELECT T1.fname, T1.lname, COUNT(*), T1.FacID FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID GROUP BY T1.FacID;

/*
Prediction Result:
('Alice', 'Smith', 2, 1)
('Alice', 'Smith', 1, 2)
('Alice', 'Smith', 2, 3)
('Alice', 'Brown', 1, 4)
*/