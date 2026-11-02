-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" INTEGER, "dept_name" INTEGER, "credits" INTEGER);

CREATE TABLE "department" ("dept_name" INTEGER, "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" INTEGER, "salary" INTEGER, "dept_name" INTEGER);

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "semester" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" INTEGER, "dept_name" INTEGER, "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: instructor --
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1, 1, -55602865, -59984348);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1, 1, -664303813, -1022641847);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1, 1, -1349201381, 1019800248);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1, 1, -1910425938, -845863578);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (NULL, 1, 1620389964, 546571701);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1, 1, 947159877, 1990080517);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1, 1, 902887186, -967741825);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1, 1, 775304493, 373262291);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1, NULL, -55602865, -59984348);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (2, 2, -845863578, -1610064545);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (3, 3, 429706943, 462974032);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (2, 2, 1990080517, 1408123494);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (3, 3, -1964997180, 1149850321);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (2, 2, 373262291, -472966518);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (3, 3, -921187550, -2070843029);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (2, 2, -1438850342, -305670381);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (3, 3, -1525670226, -453362185);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (2, 2, -1025564911, -227162283);

INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (3, 3, 2056419640, 222415430);

-- Inserting into table: teaches --
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-1726781632, 1, 247012447, -1980249628, -734455130, 1744686505);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-1633151678, 1, -252690330, 1115440883, 1644814318, 1465859724);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-1610064545, 1, 429706943, 462974032, -1137908826, -918961358);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-1602639011, NULL, -45536098, 1861536320, 44952191, 1151980946);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1408123494, 1, -1964997180, 1149850321, -1833165707, 1155439218);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1313172851, 1, -761141909, 283598170, 742285925, -747753377);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-472966518, 1, -921187550, -2070843029, 328305758, -751275471);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-1347802441, 1, 1673584235, -2118135981, 2074205376, 274769912);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (0, -664303813, -1022641847, -1726781632, 247012447, -1980249628);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-734455130, 2, 1744686505, -1633151678, -252690330, 1115440883);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1644814318, 3, 1465859724, -1349201381, 1019800248, -1910425938);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-1137908826, 2, -918961358, -1602639011, -45536098, 1861536320);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (44952191, 3, 1151980946, 1620389964, 546571701, 947159877);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-1833165707, 2, 1155439218, 1313172851, -761141909, 283598170);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (742285925, 3, -747753377, 902887186, -967741825, 775304493);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (328305758, 2, -751275471, -1347802441, 1673584235, -2118135981);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (2074205376, 3, 274769912, -188151580, 226938182, 90119032);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (481163439, 2, 2123196517, 364869063, -953437896, -1097120355);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (244829661, 3, -1362461264, -904834265, -346339240, 1692174491);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR LEFT OUTER JOIN TEACHES ON INSTRUCTOR.ID > TEACHES.ID;

/*
Gold Result:
(1, 1, 1)
(1, 1, None)
(1, 1, -664303813)
(1, 1, 2)
(None, 1, None)
(1, None, 1)
(1, None, None)
(1, None, -664303813)
(1, None, 2)
(2, 2, 1)
(2, 2, None)
(2, 2, -664303813)
(2, 2, 2)
(3, 3, 1)
(3, 3, None)
(3, 3, -664303813)
(3, 3, 2)
*/

-- Prediction Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR CROSS JOIN TEACHES WHERE INSTRUCTOR.ID = TEACHES.ID;

/*
Prediction Result:
*/