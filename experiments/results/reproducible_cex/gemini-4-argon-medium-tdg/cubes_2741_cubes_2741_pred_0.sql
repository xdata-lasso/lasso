-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Rank, secondary ordering by FacID, and ensures Fname/Lname order does not accidentally match FacID order.
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (10, 'Smith', 'Zoe', 'Professor', 'F', 1111, '101', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (20, 'Adams', 'Bob', 'Professor', 'M', 2222, '102', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Baker', 'Alice', 'AssocProf', 'F', 3333, '103', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (15, 'Clark', 'Charlie', 'AsstProf', 'M', 4444, '104', 'Science');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rank, fname, lname FROM faculty ORDER BY rank, faculty.facid NULLS LAST;

/*
Gold Result:
('AssocProf', 'Alice', 'Baker')
('AsstProf', 'Charlie', 'Clark')
('Professor', 'Zoe', 'Smith')
('Professor', 'Bob', 'Adams')
*/

-- Prediction Query
SELECT rank, Fname, Lname FROM Faculty;

/*
Prediction Result:
('AssocProf', 'Alice', 'Baker')
('Professor', 'Zoe', 'Smith')
('AsstProf', 'Charlie', 'Clark')
('Professor', 'Bob', 'Adams')
*/