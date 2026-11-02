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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-55602865, -59984348, -664303813, NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1022641847, -1726781632, 247012447, NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1980249628, -734455130, 1, 1744686505);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1633151678, -252690330, 1, 1115440883);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1644814318, 1465859724, NULL, -1349201381);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1019800248, -1910425938, NULL, NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-845863578, -1610064545, NULL, NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (429706943, 462974032, NULL, -1137908826);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-918961358, -1602639011, 1, -45536098);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1861536320, 44952191, 1, 1151980946);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1620389964, 546571701, 1, 947159877);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1990080517, 1408123494, -1964997180, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1149850321, -1833165707, 1155439218, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1313172851, -761141909, 283598170, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (742285925, -747753377, 902887186, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-967741825, 775304493, 373262291, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-472966518, -921187550, -2070843029, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (328305758, -751275471, -1347802441, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1673584235, -2118135981, 2074205376, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (274769912, -188151580, 226938182, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (90119032, -1438850342, -305670381, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT DEPT_NAME FROM COURSE AS C CROSS JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE GROUP BY DEPT_NAME) AS A WHERE C.CREDITS = A.MAX_CREDITS;

/*
Prediction Result:
(1,)
(None,)
(-1964997180,)
(1155439218,)
(283598170,)
(902887186,)
(373262291,)
(-2070843029,)
(-1347802441,)
(2074205376,)
(226938182,)
(-305670381,)
*/