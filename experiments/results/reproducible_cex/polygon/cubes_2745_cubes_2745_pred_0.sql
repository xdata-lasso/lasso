-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("actid", "activity_name") VALUES (10, 'Prince9');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (9, 'Prince9');
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (9, 12);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (9, 12);
INSERT INTO "Faculty_Participates_in" ("actid", "facid") VALUES (9, 14);
INSERT INTO "Faculty_Participates_in" ("actid", "facid") VALUES (9, 14);
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (11, 'Prince9', 'Prince9', 9, 'Prince9', 9, 9, 'Prince9');
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (12, 'Prince9', 'Prince9', 9, 'Prince9', 9, 9, 'Prince9');
INSERT INTO "Faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (13, 'Prince', 'Prince15', NULL, NULL, 18, 'Prince19', 'Jerry20');
INSERT INTO "Faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (14, 'Prince21', NULL, 'Prince9', 'Prince9', 9, 'Prince9', 'Prince9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "phone", "room", "building" FROM "faculty" WHERE ("fname" = 'Jerry' OR "lname" = 'Prince') ORDER BY phone, faculty.facid NULLS LAST;

/*
Gold Result:
(18, 'Prince19', 'Jerry20')
*/

-- Prediction Query
SELECT phone, room, building FROM Faculty WHERE Fname = 'Jerry' AND Lname = 'Prince';

/*
Prediction Result:
*/