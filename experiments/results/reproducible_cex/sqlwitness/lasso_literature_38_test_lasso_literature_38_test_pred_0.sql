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
INSERT INTO department (dept_name, building, budget) VALUES (NULL, 8, 1), ('default1', 4, 5), ('default2', 4, 11), ('default1', 8, 5), (NULL, 0, 9), (NULL, 4, 9), (NULL, 5, 8);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (7, 'default2', 'default2', 0), (4, NULL, 'default2', 7), (9, 'default1', 'default1', 9), (1, 'default2', 'default1', 10), (10, 'default2', 'default2', 1), (NULL, NULL, 'default1', NULL), (11, 'default1', 'default2', 6), (10, 'default1', 'default1', 9), (7, 'default2', 'default2', 4), (5, 'default1', NULL, 4), (4, 'default2', 'default2', 7), (1, 'default2', NULL, 10), (7, NULL, 'default1', 1), (5, 'default1', 'default2', 9), (9, 'default1', 'default1', 6), (10, NULL, NULL, 1), (11, 'default1', 'default2', 9), (7, 'default1', 'default1', 10), (5, 'default1', NULL, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('default2', 43)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/