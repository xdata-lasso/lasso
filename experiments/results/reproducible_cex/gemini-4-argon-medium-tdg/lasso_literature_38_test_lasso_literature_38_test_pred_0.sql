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
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 1, 10000);
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 2, 20000);
INSERT INTO department (dept_name, building, budget) VALUES ('History', 3, 30000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'CS1', 'CS', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'CS2', 'CS', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'CS3', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'CS4', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 'CS5', 'CS', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (106, 'CS6', 'CS', 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (107, 'CS7', 'CS', 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'M1', 'Math', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 'M2', 'Math', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 'M3', 'Math', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (204, 'M4', 'Math', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (205, 'M5', 'Math', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (206, 'M6', 'Math', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 'P1', 'Physics', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (302, 'P2', 'Physics', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (303, 'P3', 'Physics', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (304, 'P4', 'Physics', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (305, 'P5', 'Physics', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (306, 'P6', 'Physics', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('CS', 27)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/