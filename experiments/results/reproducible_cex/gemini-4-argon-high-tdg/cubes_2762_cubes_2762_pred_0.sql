-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'John', 20, 'M', 600, 2001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Doe', 'Jane', 21, 'F', 600, 2001, 'LAX');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2001, 'uring', 'Alan', 'Professor', 'M', 12345, '101A', 'Science');
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Zumba');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Archery');
INSERT INTO Activity (actid, activity_name) VALUES (3, 'Chess');
INSERT INTO Activity (actid, activity_name) VALUES (4, 'Chess');
INSERT INTO Participates_in (actid, stuid) VALUES (1, 1001);
INSERT INTO Participates_in (actid, stuid) VALUES (1, 1002);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 2001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_name FROM activity ORDER BY activity_name, activity.actid NULLS LAST;

/*
Gold Result:
('Archery',)
('Chess',)
('Chess',)
('Zumba',)
*/

-- Prediction Query
SELECT activity_name FROM Activity;

/*
Prediction Result:
('Zumba',)
('Archery',)
('Chess',)
('Chess',)
*/