-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, dept_name TEXT, credits INTEGER);

CREATE TABLE department (dept_name TEXT PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course --
INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483648, 'c_s_2461da', 2);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483647, 'c_s_2461da', 3);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483646, 'c_s_2461da', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (2, 'c_s_2461da', 2);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (3, 'c_s_2461da', 3);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483645, 'c_s_2461da', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483642, 'Y', 2);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483641, 'Y', 3);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483640, 'Y', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483639, '1', 2);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483638, '1', 3);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483637, '1', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483636, '@', 2);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483635, '@', 3);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483634, '@', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483633, '@', 2);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483632, '@', 3);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483631, '@', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483630, 'c_s_2461da', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483629, 'c_s_2461da', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483628, 'c_s_2461da', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483627, 'c_s_2461da', 4);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483626, 'c_s_2461da', NULL);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483625, 'c_s_2461da', NULL);

INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (-2147483624, 'c_s_2461da', NULL);

-- Inserting into table: department --
INSERT INTO "department" ("dept_name") VALUES ('c_s_2461da');

INSERT INTO "department" ("dept_name") VALUES ('dept_name_2');

INSERT INTO "department" ("dept_name") VALUES ('A');

INSERT INTO "department" ("dept_name") VALUES ('d_s_b8487d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 2;

/*
Gold Result:
('c_s_2461da', 34)
*/

-- Prediction Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 5;

/*
Prediction Result:
*/