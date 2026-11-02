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
INSERT INTO department (dept_name, building, budget) VALUES ('CompSci', 1, 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('History', 2, 80000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'Intro to CS', 'CompSci', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'Algorithms', 'CompSci', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'World History', 'History', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 'Ancient History', 'History', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 'Modern History', 'History', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (204, 'European History', 'History', 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2023, 1, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 1, 2023, 1, 11, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (201, 1, 2023, 2, 20, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (201, 2, 2023, 2, 21, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (202, 1, 2023, 2, 22, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (202, 2, 2023, 2, 23, 4);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (203, 1, 2023, 2, 24, 5);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (204, 1, 2023, 2, 25, 6);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 'Alice', 52000, 'CompSci');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 'Bob', 54000, 'CompSci');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 'Charlie', 56000, 'CompSci');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 'Diana', 60000, 'CompSci');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (5, 'Evan', 40000, 'History');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (6, 'Fiona', 52000, 'History');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (7, 'George', 54000, 'History');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (8, 'Hannah', 58000, 'History');
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 1, 2023, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 102, 1, 2023, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 201, 1, 2023, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 201, 2, 2023, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 202, 1, 2023, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 202, 2, 2023, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (6, 203, 1, 2023, 6);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (7, 204, 1, 2023, 7);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (8, 204, 1, 2023, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) = 4;

/*
Gold Result:
('CompSci', 55500.0)
('History', 51000.0)
*/

-- Prediction Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) > 4;

/*
Prediction Result:
*/