-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Basic DISTINCT, ORDER BY (inserted out of alphabetical order), and extraneous INNER JOINs (Faculty 1 and 2 have no activities or students).
INSERT INTO "Activity" ("actid", "activity_name") VALUES (10, 'Chess');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Smith', 'John', 'Professor', 'M', 1111, '101', 'North');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (2, 'Doe', 'Jane', 'AssocProf', 'F', 2222, '102', 'South');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (3, 'Brown', 'Bob', 'Professor', 'M', 3333, '103', 'East');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (4, 'White', 'Alice', 'Instructor', 'F', 4444, '104', 'West');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (10, 3);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (100, 'Green', 'Tom', 20, 'M', 600, 4, 'NYC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rank FROM faculty ORDER BY rank;

/*
Gold Result:
('AssocProf',)
('Instructor',)
('Professor',)
*/

-- Prediction Query
SELECT DISTINCT rank FROM Faculty;

/*
Prediction Result:
('Professor',)
('AssocProf',)
('Instructor',)
*/