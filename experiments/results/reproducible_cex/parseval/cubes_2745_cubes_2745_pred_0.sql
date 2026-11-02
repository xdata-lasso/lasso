-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: faculty --
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1, NULL, 'Jerry', 'value', 'value', 1, 'fac_f86776', 'fac_701474');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (-2147483647, NULL, 'Jerry', 'value', 'value', 1, 'fac_f86776', 'fac_701474');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (2, 'Prince', 'fac_d8837b', 'fac_80d96e', '1', -55602865, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (3, 'Prince', 'Jerry', 'fac_80d96e', '1', -59984348, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (4, 'fac_99ca16', 'Jerry', 'fac_80d96e', '1', -664303813, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (5, 'fac_99ca16', 'fac_4c42d6', 'fac_80d96e', '1', -1022641847, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (6, NULL, 'fac_4c42d6', 'fac_80d96e', '1', -1726781632, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (7, 'Prince', NULL, 'fac_80d96e', '1', 247012447, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (8, 'fac_99ca16', NULL, 'fac_80d96e', '1', -1980249628, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (9, NULL, NULL, 'fac_80d96e', '1', -734455130, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (10, NULL, 'Jerry', 'fac_80d96e', '1', NULL, '24d2f', 'fac_a140e0');

INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (11, NULL, 'Jerry', 'fac_80d96e', '1', 1744686505, NULL, 'fac_a140e0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "phone", "room", "building" FROM "faculty" WHERE ("fname" = 'Jerry' OR "lname" = 'Prince') ORDER BY phone, faculty.facid NULLS LAST;

/*
Gold Result:
(None, '24d2f', 'fac_a140e0')
(-664303813, '24d2f', 'fac_a140e0')
(-59984348, '24d2f', 'fac_a140e0')
(-55602865, '24d2f', 'fac_a140e0')
(1, 'fac_f86776', 'fac_701474')
(1, 'fac_f86776', 'fac_701474')
(247012447, '24d2f', 'fac_a140e0')
(1744686505, None, 'fac_a140e0')
*/

-- Prediction Query
SELECT phone, room, building FROM Faculty WHERE Fname = 'Jerry' AND Lname = 'Prince';

/*
Prediction Result:
(-59984348, '24d2f', 'fac_a140e0')
*/