-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT JOIN (faculty with 0 activities), COUNT(*) vs COUNT(actid) with NULL actid, and duplicate rows in Faculty_Participates_in (COUNT(*) vs COUNT(DISTINCT actid)).
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Debate');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Chess');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (101, 'Smith', 'John', 'Prof', 'M', 1111, '10A', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (102, 'Doe', 'Jane', 'Assoc', 'F', 2222, '20B', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (103, 'Brown', 'Charlie', 'Asst', 'M', 3333, '30C', 'Arts');
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 101);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 101);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 101);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (NULL, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, n AS count___, facid FROM (SELECT LHS.facid AS facid, LHS.lname AS lname, LHS.fname AS fname, LHS.rank AS rank, LHS.sex AS sex, LHS.phone AS phone, LHS.room AS room, LHS.building AS building, RHS.n AS n FROM faculty AS LHS INNER JOIN (SELECT facid, COUNT(*) AS n FROM faculty_participates_in GROUP BY facid) AS RHS ON (LHS.facid = RHS.facid)) ORDER BY fname, lname NULLS LAST, count___ NULLS LAST, facid NULLS LAST;

/*
Gold Result:
('Jane', 'Doe', 1, 102)
('John', 'Smith', 3, 101)
*/

-- Prediction Query
SELECT T1.fname, T1.lname, COUNT(*), T1.FacID FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID GROUP BY T1.FacID;

/*
Prediction Result:
('John', 'Smith', 3, 101)
('Jane', 'Doe', 1, 102)
*/