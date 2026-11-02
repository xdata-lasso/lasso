-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Missing DISTINCT (COUNT(sex) vs COUNT(DISTINCT sex)), AND vs OR condition, and column confusion (counting Rank or FacID instead of Sex).
-- Gold Query Output: 1 (Two matching rows with Sex = 'F').
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Smith', 'Alice', 'Professor', 'F', 1111, '101A', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (2, 'Jones', 'Betty', 'Professor', 'F', 2222, '102B', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (3, 'Brown', 'Charlie', 'Professor', 'M', 3333, '103C', 'Sci');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (4, 'Davis', 'Diana', 'Instructor', 'F', 4444, '104D', 'Sci');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT COUNT(DISTINCT "sex") AS "n_distinct" FROM (SELECT * FROM "faculty" WHERE ("sex" = 'F' AND "rank" = 'Professor'))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Faculty WHERE Sex = 'F' AND Rank = 'Professor';

/*
Prediction Result:
(2,)
*/