-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Debate Club');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Chess Team');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Adams', 'Zack', 'Professor', 'M', 3001, '102A', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Baker', 'Yuri', 'Instructor', 'F', 1002, '305B', 'Arts');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, 'Clark', 'Xavier', 'AssocProf', 'M', 4003, '201C', 'Engineering');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (4, 'Davis', 'Wendy', 'Professor', 'F', 2004, '101A', 'Math');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Evans', 'Victor', 'AsstProf', 'M', 5005, '404D', 'History');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (6, 'Frank', 'Uma', 'Instructor', 'F', 1506, '202B', 'Biology');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Smith', 'John', 20, 'M', 600, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Jones', 'Anna', 21, 'F', 500, 3, 'LAX');
INSERT INTO Participates_in (actid, stuid) VALUES (1, 101);
INSERT INTO Participates_in (actid, stuid) VALUES (2, 102);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 1);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 1);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rank FROM faculty ORDER BY rank;

/*
Gold Result:
('AssocProf',)
('AsstProf',)
('Instructor',)
('Professor',)
*/

-- Prediction Query
SELECT DISTINCT rank FROM Faculty;

/*
Prediction Result:
('Professor',)
('Instructor',)
('AssocProf',)
('AsstProf',)
*/