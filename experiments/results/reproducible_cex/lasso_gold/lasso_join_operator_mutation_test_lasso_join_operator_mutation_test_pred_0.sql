-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, title TEXT);

CREATE TABLE teaches (id INTEGER PRIMARY KEY, course_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "title") VALUES (1011, 'Corporate treasurer');
INSERT INTO "course" ("course_id", "title") VALUES (1013, 'Civil engineer, consulting');
INSERT INTO "teaches" ("id", "course_id", "year") VALUES (1012, 1011, 2010);
INSERT INTO "teaches" ("id", "course_id", "year") VALUES (1014, 1013, -2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
(1011, 1012)
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id >= teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(1011, 1012)
(1013, 1012)
*/