-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Chess');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Debate');
INSERT INTO Activity (actid, activity_name) VALUES (3, 'Debate');
INSERT INTO Activity (actid, activity_name) VALUES (4, 'Archery');
INSERT INTO Activity (actid, activity_name) VALUES (5, 'Swimming');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (101, 'Smith', 'John', 'Professor', 'M', 1111, '101A', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (102, 'Doe', 'Jane', 'Associate', 'F', 2222, '202B', 'Arts');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (103, 'Brown', 'Bob', 'Assistant', 'M', 3333, '303C', 'Engineering');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (201, 'Adams', 'Alice', 20, 'F', 600, 101, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (202, 'Baker', 'Bret', 21, 'M', 600, 102, 'LAX');
INSERT INTO Participates_in (actid, stuid) VALUES (5, 201);
INSERT INTO Participates_in (actid, stuid) VALUES (5, 202);
INSERT INTO Participates_in (actid, stuid) VALUES (1, 201);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 101);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 102);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 101);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 102);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 103);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (3, 103);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (4, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_name, n AS count___ FROM (SELECT LHS.actid AS actid, LHS.n AS n, RHS.activity_name AS activity_name FROM (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid) AS LHS LEFT JOIN activity AS RHS ON (LHS.actid = RHS.actid)) ORDER BY activity_name, count___ NULLS LAST;

/*
Gold Result:
('Archery', 1)
('Chess', 2)
('Debate', 1)
('Debate', 3)
*/

-- Prediction Query
SELECT T1.activity_name, COUNT(*) FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID = T2.actID GROUP BY T1.actID;

/*
Prediction Result:
('Chess', 2)
('Debate', 3)
('Debate', 1)
('Archery', 1)
*/