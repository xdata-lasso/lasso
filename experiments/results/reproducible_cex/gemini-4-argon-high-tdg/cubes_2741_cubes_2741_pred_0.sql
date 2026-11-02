-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Zeta', 'Zack', 'Professor', 'M', 5551, '101A', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Zimmer', 'Zoe', 'Assistant', 'F', 5552, '202B', 'Engineering');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, 'Alpha', 'Adam', 'Assistant', 'M', 1111, '100A', 'Arts');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (4, 'Beta', 'Bob', 'Associate', 'M', 2222, '303C', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Beta', 'Bob', 'Associate', 'M', 2222, '303C', 'Science');
INSERT INTO Activity (actid, activity_name) VALUES (10, 'Debate');
INSERT INTO Activity (actid, activity_name) VALUES (20, 'Chess');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'Sam', 20, 'M', 600, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Jones', 'Jane', 21, 'F', 600, 1, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1003, 'Brown', 'Ben', 19, 'M', 500, 2, 'CHI');
INSERT INTO Participates_in (actid, stuid) VALUES (10, 1001);
INSERT INTO Participates_in (actid, stuid) VALUES (20, 1002);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (10, 1);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (20, 1);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (10, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rank, fname, lname FROM faculty ORDER BY rank, faculty.facid NULLS LAST;

/*
Gold Result:
('Assistant', 'Zoe', 'Zimmer')
('Assistant', 'Adam', 'Alpha')
('Associate', 'Bob', 'Beta')
('Associate', 'Bob', 'Beta')
('Professor', 'Zack', 'Zeta')
*/

-- Prediction Query
SELECT rank, Fname, Lname FROM Faculty;

/*
Prediction Result:
('Professor', 'Zack', 'Zeta')
('Assistant', 'Zoe', 'Zimmer')
('Assistant', 'Adam', 'Alpha')
('Associate', 'Bob', 'Beta')
('Associate', 'Bob', 'Beta')
*/