-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Ties for the maximum faculty participation (kills LIMIT 1 mutants), ORDER BY direction (insertion order is reverse alphabetical), DISTINCT requirement (multiple faculty per max activity), and decoy maximums in student participation (kills wrong table joins).
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Zulu');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Alpha');
INSERT INTO Activity (actid, activity_name) VALUES (3, 'Beta');
INSERT INTO Activity (actid, activity_name) VALUES (4, 'Gamma');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (101, 'Smith', 'John', 'Prof', 'M', 1111, '101', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (102, 'Doe', 'Jane', 'Assoc', 'F', 2222, '102', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (103, 'Brown', 'Bob', 'Asst', 'M', 3333, '103', 'Main');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (201, 'Adams', 'Amy', 20, 'F', 10, 101, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (202, 'Baker', 'Ben', 21, 'M', 10, 101, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (203, 'Clark', 'Carl', 22, 'M', 10, 102, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (204, 'Davis', 'Dan', 19, 'M', 20, 103, 'CHI');
-- Activity 1 ('Zulu') has 3 faculty (Tied for Max)
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 101);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 102);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 103);
-- Activity 2 ('Alpha') has 3 faculty (Tied for Max)
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 101);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 102);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 103);
-- Activity 3 ('Beta') has 1 faculty (Min > 0)
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (3, 101);
-- Activity 3 ('Beta') has 4 students (Decoy Max in Participates_in)
INSERT INTO Participates_in (actid, stuid) VALUES (3, 201);
INSERT INTO Participates_in (actid, stuid) VALUES (3, 202);
INSERT INTO Participates_in (actid, stuid) VALUES (3, 203);
INSERT INTO Participates_in (actid, stuid) VALUES (3, 204);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT activity_name FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, LHS.facid AS facid, LHS.n AS n FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, LHS.facid AS facid, RHS.n AS n FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, RHS.facid AS facid FROM activity AS LHS INNER JOIN faculty_participates_in AS RHS ON (LHS.actid = RHS.actid)) AS LHS INNER JOIN (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid) AS RHS ON (LHS.actid = RHS.actid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY activity_name;

/*
Gold Result:
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT T1.activity_name FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID = T2.actID GROUP BY T1.actID ORDER BY COUNT(*) DESC, T1.activity_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/