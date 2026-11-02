-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, title TEXT);

CREATE TABLE teaches (id INTEGER PRIMARY KEY, course_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, projection distinction (course_id vs id), and year boundary predicates (<, =, >, IS NULL)
INSERT INTO course (course_id, title) VALUES (101, 'Database Systems');
INSERT INTO course (course_id, title) VALUES (102, 'Compilers');
INSERT INTO teaches (id, course_id, year) VALUES (1, 101, 2009);
INSERT INTO teaches (id, course_id, year) VALUES (2, 101, 2010);
INSERT INTO teaches (id, course_id, year) VALUES (3, 101, 2011);
INSERT INTO teaches (id, course_id, year) VALUES (4, 102, 2010);
INSERT INTO teaches (id, course_id, year) VALUES (5, 102, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
(101, 2)
(102, 4)
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id >= teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(101, 2)
(102, 2)
(102, 4)
*/