-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (100, 'Clark', NULL, 'Professor', 'F', NULL, '301', 'North');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (50, 'Lewis', 'Zoe', 'Assoc Prof', 'F', 9998888, '302', 'South');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (75, 'Walker', 'Amy', 'Asst Prof', 'F', 7776666, '303', 'East');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (25, NULL, 'Amy', 'Instructor', 'F', 4445555, '304', 'West');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname", "phone" FROM "faculty" WHERE ("sex" = 'F') ORDER BY fname, faculty.facid NULLS LAST;

/*
Gold Result:
(None, 'Clark', None)
('Amy', None, 4445555)
('Amy', 'Walker', 7776666)
('Zoe', 'Lewis', 9998888)
*/

-- Prediction Query
SELECT Fname, Lname, phone FROM Faculty WHERE Sex = 'F';

/*
Prediction Result:
('Amy', None, 4445555)
('Zoe', 'Lewis', 9998888)
('Amy', 'Walker', 7776666)
(None, 'Clark', None)
*/