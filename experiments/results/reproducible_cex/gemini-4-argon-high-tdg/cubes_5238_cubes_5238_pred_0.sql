-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Chess Club');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Debate Team');
INSERT INTO Activity (actid, activity_name) VALUES (3, 'Robotics');
INSERT INTO Activity (actid, activity_name) VALUES (10, 'Drama');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Brown', 'Sam', 20, 'M', 600, 40, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Green', 'Lily', 21, 'F', 600, 10, 'BOS');
INSERT INTO Participates_in (actid, stuid) VALUES (1, 10);
INSERT INTO Participates_in (actid, stuid) VALUES (2, 10);
INSERT INTO Participates_in (actid, stuid) VALUES (3, 10);
INSERT INTO Participates_in (actid, stuid) VALUES (10, 20);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (10, 'Beta', 'Bob', 'Professor', 'M', 1111, '101A', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (20, 'Alpha', 'Bob', 'AsstProf', 'M', 2222, '202B', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (30, 'Zeta', 'Alice', 'Instructor', 'F', 3333, '303C', 'Arts');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (40, 'Delta', 'Charlie', 'Professor', 'F', 4444, '404D', 'Main');
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (10, 10);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 20);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 20);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (10, 20);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 30);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (3, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, n AS count___, facid FROM (SELECT LHS.facid AS facid, LHS.lname AS lname, LHS.fname AS fname, LHS.rank AS rank, LHS.sex AS sex, LHS.phone AS phone, LHS.room AS room, LHS.building AS building, RHS.n AS n FROM faculty AS LHS INNER JOIN (SELECT facid, COUNT(*) AS n FROM faculty_participates_in GROUP BY facid) AS RHS ON (LHS.facid = RHS.facid)) ORDER BY fname, lname NULLS LAST, count___ NULLS LAST, facid NULLS LAST;

/*
Gold Result:
('Alice', 'Zeta', 2, 30)
('Bob', 'Alpha', 3, 20)
('Bob', 'Beta', 1, 10)
*/

-- Prediction Query
SELECT T1.fname, T1.lname, COUNT(*), T1.FacID FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID GROUP BY T1.FacID;

/*
Prediction Result:
('Bob', 'Beta', 1, 10)
('Bob', 'Alpha', 3, 20)
('Alice', 'Zeta', 2, 30)
*/