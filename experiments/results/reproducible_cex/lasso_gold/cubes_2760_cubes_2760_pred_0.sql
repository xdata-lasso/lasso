-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1032, 'Jackson', 'Joseph', 'Instructor', 'away', 1033, 'maintain', 'hundred');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1034, 'Miles', 'Frances', 'Instructor', 'common', 1034, 'politics', 'prove');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM "faculty" WHERE ("rank" = 'Instructor') ORDER BY fname, faculty.facid NULLS LAST;

/*
Gold Result:
('Frances', 'Miles')
('Joseph', 'Jackson')
*/

-- Prediction Query
SELECT fname, lname FROM Faculty WHERE Rank = 'Instructor';

/*
Prediction Result:
('Joseph', 'Jackson')
('Frances', 'Miles')
*/