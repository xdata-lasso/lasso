-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, title TEXT);

CREATE TABLE teaches (id INTEGER PRIMARY KEY, course_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course --
INSERT INTO "course" ("course_id", "title") VALUES (1, '5k5swwqcgs');

INSERT INTO "course" ("course_id", "title") VALUES (21240, '5k5swwqcgs');

INSERT INTO "course" ("course_id", "title") VALUES (-21238, '9n8');

INSERT INTO "course" ("course_id", "title") VALUES (2, '4');

INSERT INTO "course" ("course_id", "title") VALUES (3, 'hria2ypu');

-- Inserting into table: teaches --
INSERT INTO "teaches" ("id", "course_id", "year") VALUES (1, 247012447, 2010);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (2, 21240, 1);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (3, 0, NULL);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (4, -734455130, 1744686505);

INSERT INTO "teaches" ("id", "course_id", "year") VALUES (5, 1644814318, 1465859724);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id <= teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(-21238, 1)
(1, 1)
(2, 1)
(3, 1)
(21240, 1)
*/