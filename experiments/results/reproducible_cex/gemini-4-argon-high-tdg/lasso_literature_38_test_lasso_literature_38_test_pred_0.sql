-- Schema DDL
CREATE TABLE course (course_id INTEGER, title TEXT(255), dept_name TEXT(255), credits INTEGER);

CREATE TABLE department (dept_name TEXT(255), building INTEGER, budget INTEGER);

CREATE TABLE instructor (ID INTEGER, name TEXT(255), salary INTEGER, dept_name TEXT(255));

CREATE TABLE teaches (ID INTEGER, course_id INTEGER, sec_id INTEGER, year INTEGER, instructor INTEGER);

CREATE TABLE section (course_id INTEGER, sec_id INTEGER, year INTEGER, building INTEGER, room_number INTEGER, time_slot_id INTEGER);

CREATE TABLE takes (ID INTEGER, course_id INTEGER, sec_id INTEGER, year INTEGER, grade INTEGER);

CREATE TABLE student (ID INTEGER, name TEXT(255), dept_name TEXT(255), tot_cred INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (dept_name, building, budget) VALUES ('Comp. Sci.', 101, 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Biology', 102, 80000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'CS1', 'Comp. Sci.', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'CS2', 'Comp. Sci.', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'CS3', 'Comp. Sci.', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'CS4', 'Comp. Sci.', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 'CS5', 'Comp. Sci.', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (106, 'CS6', 'Comp. Sci.', 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (107, 'CS7', 'Comp. Sci.', 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'H1', 'History', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 'H2', 'History', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 'H3', 'History', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (204, 'H4', 'History', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (205, 'H5', 'History', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (206, 'H6', 'History', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('Comp. Sci.', 27)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/