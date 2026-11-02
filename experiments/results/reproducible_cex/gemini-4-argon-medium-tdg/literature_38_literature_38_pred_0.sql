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
-- Tests standard valid group (D1), COUNT(DISTINCT) vs COUNT(*) (D2), and boundary conditions on HAVING clauses (D3, D4, D5)
INSERT INTO department (dept_name, building, budget) VALUES ('D1', 1, 1000);
INSERT INTO department (dept_name, building, budget) VALUES ('D2', 2, 2000);
INSERT INTO department (dept_name, building, budget) VALUES ('D3', 3, 3000);
INSERT INTO department (dept_name, building, budget) VALUES ('D4', 4, 4000);
INSERT INTO department (dept_name, building, budget) VALUES ('D5', 5, 5000);
-- D1: Valid (6 distinct credits: 1,2,3,4,5,6; SUM = 21 > 10)
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'C1', 'D1', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'C2', 'D1', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'C3', 'D1', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'C4', 'D1', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 'C5', 'D1', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (106, 'C6', 'D1', 6);
-- D2: Fails COUNT(DISTINCT C.CREDITS) > 5 (6 courses, but only 5 distinct credits: 1,2,3,4,5; SUM = 20 > 10). Catches missing DISTINCT in COUNT.
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'C1', 'D2', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 'C2', 'D2', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 'C3', 'D2', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (204, 'C4', 'D2', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (205, 'C5', 'D2', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (206, 'C6', 'D2', 5);
-- D3: Fails SUM(C.CREDITS) > 10 boundary (6 distinct credits: -5,1,2,3,4,5; SUM = 10). Catches >= 10 vs > 10 and OR vs AND.
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 'C1', 'D3', -5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (302, 'C2', 'D3', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (303, 'C3', 'D3', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (304, 'C4', 'D3', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (305, 'C5', 'D3', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (306, 'C6', 'D3', 5);
-- D4: Passes SUM(C.CREDITS) > 10 boundary (6 distinct credits: -4,1,2,3,4,5; SUM = 11 > 10).
INSERT INTO course (course_id, title, dept_name, credits) VALUES (401, 'C1', 'D4', -4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (402, 'C2', 'D4', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (403, 'C3', 'D4', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (404, 'C4', 'D4', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (405, 'C5', 'D4', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (406, 'C6', 'D4', 5);
-- D5: Fails COUNT(DISTINCT) > 5 boundary (5 distinct credits: 1,2,3,4,5; SUM = 15 > 10). Catches >= 5 vs > 5 and OR vs AND.
INSERT INTO course (course_id, title, dept_name, credits) VALUES (501, 'C1', 'D5', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (502, 'C2', 'D5', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (503, 'C3', 'D5', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (504, 'C4', 'D5', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (505, 'C5', 'D5', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('D1', 21)
('D4', 11)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/