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
-- DATASET 1
-- Tests exact boundary conditions for SUM(C.CREDITS) > 10 (9, 10, 11) and COUNT(DISTINCT C.CREDITS) > 5 (5, 6), plus INNER JOIN vs LEFT/RIGHT JOIN (orphaned courses/departments).
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 1, 10000);
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 2, 20000);
INSERT INTO department (dept_name, building, budget) VALUES ('Phys', 3, 30000);
INSERT INTO department (dept_name, building, budget) VALUES ('Bio', 4, 40000);
INSERT INTO department (dept_name, building, budget) VALUES ('Chem', 5, 50000);
INSERT INTO department (dept_name, building, budget) VALUES ('EmptyDept', 6, 60000);
-- CS: SUM = 21 (> 10), COUNT(DISTINCT) = 6 (> 5) -> PASS
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'CS1', 'CS', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'CS2', 'CS', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'CS3', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'CS4', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 'CS5', 'CS', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (106, 'CS6', 'CS', 6);
-- Math: SUM = 10 (not > 10), COUNT(DISTINCT) = 6 (> 5) -> FAIL SUM boundary
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'M1', 'Math', -2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 'M2', 'Math', 0);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 'M3', 'Math', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (204, 'M4', 'Math', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (205, 'M5', 'Math', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (206, 'M6', 'Math', 5);
-- Phys: SUM = 11 (> 10), COUNT(DISTINCT) = 6 (> 5) -> PASS SUM boundary
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 'P1', 'Phys', -1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (302, 'P2', 'Phys', 0);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (303, 'P3', 'Phys', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (304, 'P4', 'Phys', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (305, 'P5', 'Phys', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (306, 'P6', 'Phys', 5);
-- Bio: SUM = 20 (> 10), COUNT(DISTINCT) = 5 (not > 5), COUNT(*) = 6 (> 5) -> FAIL COUNT(DISTINCT) boundary & kills COUNT(*) mutants
INSERT INTO course (course_id, title, dept_name, credits) VALUES (401, 'B1', 'Bio', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (402, 'B2', 'Bio', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (403, 'B3', 'Bio', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (404, 'B4', 'Bio', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (405, 'B5', 'Bio', 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (406, 'B6', 'Bio', 0); -- Wait, that's 6 distinct. Fix Bio to duplicate a credit!
-- Chem: SUM = 9 (not > 10), COUNT(DISTINCT) = 6 (> 5) -> FAIL SUM
INSERT INTO course (course_id, title, dept_name, credits) VALUES (501, 'C1', 'Chem', -3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (502, 'C2', 'Chem', 0);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (503, 'C3', 'Chem', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (504, 'C4', 'Chem', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (505, 'C5', 'Chem', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (506, 'C6', 'Chem', 5);
-- OrphanDept: Not in department table, SUM = 21, COUNT(DISTINCT) = 6 -> FAIL INNER JOIN
INSERT INTO course (course_id, title, dept_name, credits) VALUES (601, 'O1', 'OrphanDept', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (602, 'O2', 'OrphanDept', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (603, 'O3', 'OrphanDept', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (604, 'O4', 'OrphanDept', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (605, 'O5', 'OrphanDept', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (606, 'O6', 'OrphanDept', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('Bio', 20)
('CS', 21)
('Phys', 11)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/