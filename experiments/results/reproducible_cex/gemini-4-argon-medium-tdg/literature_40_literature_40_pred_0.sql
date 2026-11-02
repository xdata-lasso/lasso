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
-- DATASET 4
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('CS', 101, 50000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Math', 102, 40000);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 'Intro CS', 'CS', 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (2, 'Algorithms', 'CS', 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (3, 'Calculus', 'Math', 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (4, 'Algebra', 'Math', 3);
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (10, 'Alice', 'CS', 30);
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (10, 'Alice', 'Math', 30);
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (20, 'Bob', 'CS', 30);
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (20, 'Bob', 'Math', 30);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1, 1, 2023, 101, 1, 1);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (2, 1, 2023, 101, 1, 2);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (3, 1, 2023, 102, 2, 1);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (4, 1, 2023, 102, 2, 2);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (10, 1, 1, 2023, 90);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (10, 3, 1, 2023, 85);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (20, 1, 1, 2023, 80);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (20, 2, 1, 2023, 82);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (20, 3, 1, 2023, 88);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (20, 4, 1, 2023, 91);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID, STUDENT.DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
(20,)
(20,)
*/

-- Prediction Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(10,)
(20,)
*/