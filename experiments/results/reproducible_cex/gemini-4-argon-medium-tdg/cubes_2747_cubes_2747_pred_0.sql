-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Activity" ("actid", "activity_name") VALUES (101, 'Debate');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Smith', 'John', 'Professor', 'M', 1111, '101A', 'NEB');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (2, 'Doe', 'Jane', 'Instructor', 'F', 2222, '202B', 'Barton');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (3, 'Brown', 'Bob', 'AsstProf', 'M', 3333, '101A', 'NEB');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (4, 'White', 'Alice', 'AssocProf', 'F', 4444, '303C', 'Gates');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 1);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 3);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Green', 'Tom', 20, 'M', 600, 1, 'NYC');
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (101, 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT building FROM faculty ORDER BY building;

/*
Gold Result:
('Barton',)
('Gates',)
('NEB',)
*/

-- Prediction Query
SELECT DISTINCT building FROM Faculty;

/*
Prediction Result:
('NEB',)
('Barton',)
('Gates',)
*/