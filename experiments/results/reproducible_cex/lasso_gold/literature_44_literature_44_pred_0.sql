-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" TEXT(255), "dept_name" TEXT(255), "credits" INTEGER);

CREATE TABLE "department" ("dept_name" TEXT(255), "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" TEXT(255), "salary" INTEGER, "dept_name" TEXT(255));

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" TEXT(255), "dept_name" TEXT(255), "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1001, 1006, 1011, 1012, 1017, 1022);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1004.0, 1011.0, 1011, 1021.0, 1028.0, 1022);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1007.0, 1016.0, 1011, 1030.0, 1039.0, 1022);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1010.0, 1021.0, 1011, 1039.0, 1050.0, 1022);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1013.0, 1026.0, 1011, 1048.0, 1061.0, 1022);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1023, 'Allison Hill', 'Noah Rhodes', 1024);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1023, 1001, 1006, 1011, 1025);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1023, 1004.0, 1011.0, 1011, 1036.0);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1023, 1007.0, 1016.0, 1011, 1047.0);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1023, 1010.0, 1021.0, 1011, 1058.0);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1023, 1013.0, 1026.0, 1011, 1069.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH S AS (SELECT ID, TIME_SLOT_ID, YEAR FROM TAKES NATURAL JOIN SECTION GROUP BY ID, TIME_SLOT_ID, YEAR HAVING COUNT(TIME_SLOT_ID) > 4) SELECT DISTINCT ID, NAME FROM S NATURAL JOIN STUDENT;

/*
Gold Result:
(1023, 'Allison Hill')
*/

-- Prediction Query
WITH S AS (SELECT ID, TIME_SLOT_ID, YEAR FROM TAKES NATURAL JOIN SECTION GROUP BY ID, TIME_SLOT_ID, YEAR HAVING COUNT(TIME_SLOT_ID) > 5) SELECT DISTINCT ID, NAME FROM S NATURAL JOIN STUDENT;

/*
Prediction Result:
*/