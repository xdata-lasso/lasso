-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, dept_name TEXT, credits INTEGER);

CREATE TABLE department (dept_name TEXT PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (1001, 'Allison Hill', 1004);
INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (1002, 'Allison Hill', 1005);
INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (1003, 'Allison Hill', 1006);
INSERT INTO "department" ("dept_name") VALUES ('Allison Hill');
INSERT INTO "department" ("dept_name") VALUES ('Noah Rhodes');
INSERT INTO "department" ("dept_name") VALUES ('Angie Henderson');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 2;

/*
Gold Result:
('Allison Hill', 3015)
*/

-- Prediction Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 5;

/*
Prediction Result:
*/