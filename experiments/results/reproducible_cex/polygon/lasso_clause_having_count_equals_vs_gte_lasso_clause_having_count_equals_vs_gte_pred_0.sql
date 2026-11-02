-- Schema DDL
CREATE TABLE department (dept_name INTEGER, building INTEGER, budget INTEGER);

CREATE TABLE teaches (id INTEGER, year INTEGER, semester INTEGER);

CREATE TABLE course (course_id INTEGER, dept_name INTEGER, credits INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (79, 78, 146);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (79, 80, 146);
INSERT INTO "teaches" ("id", "year", "semester") VALUES (79, NULL, 79);
INSERT INTO "teaches" ("id", "year", "semester") VALUES (81, 142, 82);
INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (NULL, 79, 5580);
INSERT INTO "course" ("course_id", "dept_name", "credits") VALUES (26, 79, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.semester, SUM(C.credits) FROM department AS D INNER JOIN teaches AS T ON D.budget = T.year + 4 INNER JOIN course AS C ON C.dept_name = D.dept_name GROUP BY T.semester HAVING AVG(C.credits) > 2 AND COUNT(D.building) = 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.semester, SUM(C.credits) FROM department AS D INNER JOIN teaches AS T ON D.budget = T.year + 4 INNER JOIN course AS C ON C.dept_name = D.dept_name GROUP BY T.semester HAVING AVG(C.credits) > 2 AND COUNT(D.building) >= 2;

/*
Prediction Result:
(82, 11160)
*/