-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, title TEXT);

CREATE TABLE teaches (id INTEGER PRIMARY KEY, course_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO teaches (id, course_id, year) VALUES (2009, 2010, 2010), (2011, 0, NULL), (0, 2011, 2011), (2010, 2009, 2009);
INSERT INTO course (course_id, title) VALUES (2011, NULL), (2009, 'default1'), (1, NULL), (2010, NULL), (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
(2010, 2009)
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id <= teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(0, 2009)
(1, 2009)
(2009, 2009)
(2010, 2009)
*/