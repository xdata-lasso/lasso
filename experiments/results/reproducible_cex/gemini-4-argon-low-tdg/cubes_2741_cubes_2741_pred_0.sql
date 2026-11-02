-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Rank, tie-breaking by FacID (out of physical insertion order), and detects unintended DISTINCT or JOINs.
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Debate');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (20, 'Smith', 'John', 'Professor', 'M', 1111, '101', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (10, 'Smith', 'John', 'Professor', 'M', 2222, '102', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (5, 'Doe', 'Jane', 'AssocProf', 'F', 3333, '103', 'Sci');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (30, 'Adams', 'Bob', 'Instructor', 'M', 4444, '104', 'Art');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 10);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rank, fname, lname FROM faculty ORDER BY rank, faculty.facid NULLS LAST;

/*
Gold Result:
('AssocProf', 'Jane', 'Doe')
('Instructor', 'Bob', 'Adams')
('Professor', 'John', 'Smith')
('Professor', 'John', 'Smith')
*/

-- Prediction Query
SELECT rank, Fname, Lname FROM Faculty;

/*
Prediction Result:
('AssocProf', 'Jane', 'Doe')
('Professor', 'John', 'Smith')
('Professor', 'John', 'Smith')
('Instructor', 'Bob', 'Adams')
*/