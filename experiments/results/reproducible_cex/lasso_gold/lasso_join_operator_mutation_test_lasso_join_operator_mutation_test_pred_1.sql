-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, title TEXT);

CREATE TABLE teaches (id INTEGER PRIMARY KEY, course_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "title") VALUES (1018, 'Chartered loss adjuster');
INSERT INTO "course" ("course_id", "title") VALUES (1022, 'Pharmacist, hospital');
INSERT INTO "teaches" ("id", "course_id", "year") VALUES (1019, 1018, 2010);
INSERT INTO "teaches" ("id", "course_id", "year") VALUES (1021, 1018, 2010);
INSERT INTO "teaches" ("id", "course_id", "year") VALUES (1023, 1022, 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
(1018, 1019)
(1018, 1021)
(1022, 1023)
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id <= teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(1018, 1019)
(1018, 1021)
(1018, 1023)
(1022, 1023)
*/