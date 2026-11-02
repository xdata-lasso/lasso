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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1242, 'Occupational hygienist', 'Matthew Bryant', 1243);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Matthew Bryant', 1244, 1245);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1246, 'Taylor Smith', 50001, 'Matthew Bryant');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1246, 'Taylor Smith', 50002, 'Matthew Bryant');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1246, 'Taylor Smith', 50003, 'Matthew Bryant');
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1246, 'Taylor Smith', 50004, 'Matthew Bryant');
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "instructor") VALUES (1253, 1242, 1254, 1255, 1256);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) = 4;

/*
Gold Result:
('Matthew Bryant', 50002.5)
*/

-- Prediction Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) > 4;

/*
Prediction Result:
*/