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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1392, 1393, 1394, 1395);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1394, 1396, 1397);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1398, 1402, 50001, 1394);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1398, 1402, 50002, 1394);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1398, 1402, 50003, 1394);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1398, 1402, 50004, 1394);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1409, 1392, 1410, 1411, 1412, 1413);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) = 4;

/*
Gold Result:
(1394, 50002.5)
*/

-- Prediction Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) > 4;

/*
Prediction Result:
*/