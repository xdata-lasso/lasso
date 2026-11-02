-- Schema DDL
CREATE TABLE "COURSE" (
    "COURSE_ID" INT,
    "TITLE" TEXT,
    PRIMARY KEY ("COURSE_ID")
);
CREATE TABLE "TEACHES" (
    "ID" INT,
    "COURSE_ID" INT,
    "YEAR" INT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COURSE VALUES (1, 7);
INSERT INTO COURSE VALUES (0, 8);
INSERT INTO TEACHES VALUES (0, 1, 2011);
INSERT INTO TEACHES VALUES (-1, 0, 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id = teaches.course_id WHERE teaches.year = 2010;

/*
Gold Result:
(0, -1)
*/

-- Prediction Query
SELECT course.course_id, teaches.id FROM course JOIN teaches ON course.course_id <> teaches.course_id WHERE teaches.year = 2010;

/*
Prediction Result:
(1, -1)
*/