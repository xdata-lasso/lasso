-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Baker', 'Charlie', 'Instructor', 'M', 1111, '101A', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Zimmer', 'Alice', 'Instructor', 'F', 2222, '102B', 'Arts');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, 'Carter', 'Bob', 'Professor', 'M', 3333, '201C', 'Engineering');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (4, 'Adams', 'Alice', 'Instructor', 'F', 4444, '103D', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Davis', 'Bob', 'Instructor', 'M', 5555, '104E', 'Math');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (6, 'Evans', 'Diana', 'AsstProf', 'F', 6666, '301F', 'Arts');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM "faculty" WHERE ("rank" = 'Instructor') ORDER BY fname, faculty.facid NULLS LAST;

/*
Gold Result:
('Alice', 'Zimmer')
('Alice', 'Adams')
('Bob', 'Davis')
('Charlie', 'Baker')
*/

-- Prediction Query
SELECT fname, lname FROM Faculty WHERE Rank = 'Instructor';

/*
Prediction Result:
('Charlie', 'Baker')
('Alice', 'Zimmer')
('Alice', 'Adams')
('Bob', 'Davis')
*/