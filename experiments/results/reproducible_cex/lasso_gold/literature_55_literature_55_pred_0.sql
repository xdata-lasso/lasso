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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1191, 1193, 1195, 1196);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1194.0, 1198.0, 1195, 1205.0);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1217, 1219, 1196, 1221);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1220.0, 1224.0, 1196, 1230.0);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1221.0, 1224.0, 1196, 1230.0);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1195, 1198, 1200);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1195, 1203.0, 1207.0);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1196, 1223, 1225);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1196, 1228.0, 1232.0);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1191, 1202, 1204, 1198, 1206, 1208);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1194.0, 1207.0, 1211.0, 1203.0, 1217.0, 1221.0);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1217, 1227, 1229, 1223, 1231, 1233);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1220.0, 1232.0, 1236.0, 1228.0, 1242.0, 1246.0);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1210, 1211, 1195, 1213);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1210, 1216.0, 1195, 1222.0);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1210, 1235, 1196, 1237);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1210, 1240.0, 1196, 1246.0);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1210, 1191, 1202, 1204, 1215);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1210, 1194.0, 1207.0, 1211.0, 1226.0);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1210, 1217, 1227, 1229, 1239);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1210, 1220.0, 1232.0, 1236.0, 1250.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY ID, DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
(1210,)
(1210,)
*/

-- Prediction Query
SELECT ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(1210,)
*/