-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, title TEXT);

CREATE TABLE teaches (id INTEGER PRIMARY KEY, course_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (course_id, title) VALUES (101, 'Intro to CS');
INSERT INTO course (course_id, title) VALUES (102, 'Databases');
INSERT INTO course (course_id, title) VALUES (103, 'Algorithms');
INSERT INTO teaches (id, course_id, year) VALUES (1, 101, 2009);
INSERT INTO teaches (id, course_id, year) VALUES (2, 101, 2010);
INSERT INTO teaches (id, course_id, year) VALUES (3, 101, 2010);
INSERT INTO teaches (id, course_id, year) VALUES (4, 101, 2011);
INSERT INTO teaches (id, course_id, year) VALUES (5, 102, 2009);
INSERT INTO teaches (id, course_id, year) VALUES (6, 999, 2010);
INSERT INTO teaches (id, course_id, year) VALUES (7, 101, NULL);
INSERT INTO teaches (id, course_id, year) VALUES (8, NULL, 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
(101, 2)
(101, 3)
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id <> teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(101, 6)
(102, 2)
(102, 3)
(102, 6)
(103, 2)
(103, 3)
(103, 6)
*/