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
-- Inserting into table: course --
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, -55602865, -59984348);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, -664303813, -1022641847);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (2, 1, -252690330, 1115440883);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (2, 1, 1644814318, 1465859724);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, 462974032, -1137908826);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, -918961358, -1602639011);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, 947159877, 1990080517);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, 1408123494, -1964997180);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, NULL, 742285925, -747753377);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, NULL, 902887186, -967741825);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, -751275471, -1347802441);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, 1673584235, -2118135981);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, -305670381, -1525670226, -453362185);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 481163439, 2123196517, 364869063);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 222415430, 556727997, 1178000634);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (NULL, -283454505, 233994589, 1442655647);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, -55602865, -59984348, -664303813);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (2, 2, -1980249628, -734455130);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (3, 3, 1744686505, -1633151678);

-- Inserting into table: teaches --
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, -1726781632, 2010, 247012447, -1980249628);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, -734455130, 2010, 1744686505, -1633151678);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 3, -1349201381, 2010, 1019800248, -1910425938);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 4, -845863578, 2010, -1610064545, 429706943);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, -45536098, 1, 1861536320, 44952191);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, 1151980946, 1, 1620389964, 546571701);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, 1149850321, 2010, -1833165707, 1155439218);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, 1313172851, 2010, -761141909, 283598170);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, 775304493, 2010, 373262291, -472966518);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, -921187550, 2010, -2070843029, 328305758);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, 2074205376, 2010, 274769912, -188151580);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 1, 226938182, 2010, 90119032, -1438850342);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, -953437896, -1097120355, 244829661, -1362461264, -904834265);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, -346339240, 1692174491, -1025564911, -227162283, 2056419640);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1836127587, 1, -1529584866, NULL, 1196308825, 910894705);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-87647544, 1, -629784617, 2010, -1929953647, 1581736075);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (NULL, 1, -1022641847, 2010, -1726781632, 247012447);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (2, -252690330, 1115440883, 1644814318, 1465859724, -1349201381);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 1019800248, -1910425938, -845863578, -1610064545, 429706943);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COURSE.COURSE_ID, COURSE.TITLE, TEACHES.ID FROM COURSE CROSS JOIN TEACHES WHERE COURSE.COURSE_ID = TEACHES.COURSE_ID AND TEACHES.YEAR = 2010;

/*
Gold Result:
(1, 1, None)
(1, 1, -87647544)
(1, 1, 1)
(1, None, None)
(1, None, -87647544)
(1, None, 1)
(1, -305670381, None)
(1, -305670381, -87647544)
(1, -305670381, 1)
(1, 481163439, None)
(1, 481163439, -87647544)
(1, 481163439, 1)
(1, 222415430, None)
(1, 222415430, -87647544)
(1, 222415430, 1)
(1, -55602865, None)
(1, -55602865, -87647544)
(1, -55602865, 1)
(3, 3, 1)
*/

-- Prediction Query
SELECT DISTINCT COURSE.COURSE_ID, COURSE.TITLE, TEACHES.ID FROM COURSE CROSS JOIN TEACHES WHERE COURSE.COURSE_ID >= TEACHES.COURSE_ID AND TEACHES.YEAR = 2010;

/*
Prediction Result:
(1, 1, None)
(1, 1, -87647544)
(1, 1, 1)
(2, 1, None)
(2, 1, -87647544)
(2, 1, 1)
(1, None, None)
(1, None, -87647544)
(1, None, 1)
(1, -305670381, None)
(1, -305670381, -87647544)
(1, -305670381, 1)
(1, 481163439, None)
(1, 481163439, -87647544)
(1, 481163439, 1)
(1, 222415430, None)
(1, 222415430, -87647544)
(1, 222415430, 1)
(1, -55602865, None)
(1, -55602865, -87647544)
(1, -55602865, 1)
(2, 2, None)
(2, 2, -87647544)
(2, 2, 1)
(3, 3, None)
(3, 3, -87647544)
(3, 3, 1)
*/