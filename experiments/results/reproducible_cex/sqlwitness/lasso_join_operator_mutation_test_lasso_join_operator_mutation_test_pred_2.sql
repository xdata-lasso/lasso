-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, title TEXT);

CREATE TABLE teaches (id INTEGER PRIMARY KEY, course_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO teaches (id, course_id, year) VALUES (0, 2011, 1), (2011, 0, 1), (2010, 1, 2010), (2009, NULL, 2009), (1, NULL, NULL), (2, 2010, 2010), (3, 2009, NULL);
INSERT INTO course (course_id, title) VALUES (2011, 'default1'), (2010, 'default2'), (1, NULL), (0, NULL), (2009, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
(2010, 2)
(1, 2010)
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id <> teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(0, 2010)
(0, 2)
(1, 2)
(2009, 2010)
(2009, 2)
(2010, 2010)
(2011, 2010)
(2011, 2)
*/