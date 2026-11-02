-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, title TEXT);

CREATE TABLE teaches (id INTEGER PRIMARY KEY, course_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course --
INSERT INTO "course" ("course_id", "title") VALUES (1, '5k5swwqcgs');

INSERT INTO "course" ("course_id", "title") VALUES (3, '9n8');

INSERT INTO "course" ("course_id", "title") VALUES (2, '5k5swwqcgs');

INSERT INTO "course" ("course_id", "title") VALUES (4, '9n8');

-- Inserting into table: teaches --
INSERT INTO "teaches" ("id", "course_id", "year") VALUES (1, 1, 2010);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (-2147483647, 1, 2010);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (-2147483646, 1, 2010);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (-2147483645, 1, 2010);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (2, 2, 1);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (3, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
(1, -2147483647)
(1, -2147483646)
(1, -2147483645)
(1, 1)
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id <> teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(2, -2147483647)
(2, -2147483646)
(2, -2147483645)
(2, 1)
(3, -2147483647)
(3, -2147483646)
(3, -2147483645)
(3, 1)
(4, -2147483647)
(4, -2147483646)
(4, -2147483645)
(4, 1)
*/