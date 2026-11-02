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
-- DATASET 3
-- Tests GROUP BY clause variations and same course taken multiple times.
-- Checks:
-- 1. Student taking the SAME course in two different years/sections (COUNT(dept_name) = 2, COUNT(DISTINCT course_id) = 1).
-- 2. Two students in the same department each taking 1 course (kills mutants grouping only by dept_name instead of student.ID).
-- 3. One student ID associated with two different departments, 1 course in each (kills mutants grouping only by student.ID without student.dept_name).
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Physics', 300, 60000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Bio', 400, 50000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Chem', 500, 50000);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (301, 'Mech', 'Physics', 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (401, 'Genetics', 'Bio', 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (501, 'OrgChem', 'Chem', 4);
-- Two sections of the SAME Physics course in different years
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (301, 1, 2022, 300, 10, 1);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (301, 1, 2023, 300, 10, 1);
-- Sections for Bio and Chem
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (401, 1, 2023, 400, 20, 2);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (501, 1, 2023, 500, 30, 3);
-- Student 100: Retakes the same Physics course 301 in 2022 and 2023. (Should be returned).
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (100, 'Retaker', 'Physics', 8);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (100, 301, 1, 2022, 60);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (100, 301, 1, 2023, 95);
-- Students 201 and 202: Both in Bio, each takes 1 Bio course. Total for Bio = 2, but per student = 1. (Neither should be returned).
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (201, 'BioOne', 'Bio', 4);
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (202, 'BioTwo', 'Bio', 4);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (201, 401, 1, 2023, 88);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (202, 401, 1, 2023, 92);
-- Student ID 300: Dual-record student in Bio and Chem, taking 1 course in Bio and 1 course in Chem.
-- Grouped by (ID, dept_name), each group has count = 1. Grouped only by ID, count = 2. (Should NOT be returned).
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (300, 'DualMajor', 'Bio', 4);
INSERT INTO "student" ("ID", "name", "dept_name", "tot_cred") VALUES (300, 'DualMajor', 'Chem', 4);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (300, 401, 1, 2023, 85);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "year", "grade") VALUES (300, 501, 1, 2023, 85);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID, STUDENT.DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
(100,)
*/

-- Prediction Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(100,)
(300,)
*/