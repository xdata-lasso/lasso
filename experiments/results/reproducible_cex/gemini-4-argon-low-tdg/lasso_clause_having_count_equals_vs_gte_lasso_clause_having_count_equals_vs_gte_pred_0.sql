-- Schema DDL
CREATE TABLE department (dept_name INTEGER, building INTEGER, budget INTEGER);

CREATE TABLE teaches (id INTEGER, year INTEGER, semester INTEGER);

CREATE TABLE course (course_id INTEGER, dept_name INTEGER, credits INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 2024);
INSERT INTO department (dept_name, building, budget) VALUES (2, 20, 2024);
INSERT INTO department (dept_name, building, budget) VALUES (3, 30, 2024);
INSERT INTO department (dept_name, building, budget) VALUES (4, 40, 2024);
INSERT INTO department (dept_name, building, budget) VALUES (5, 50, 2024);
INSERT INTO teaches (id, year, semester) VALUES (1, 2020, 1);
INSERT INTO teaches (id, year, semester) VALUES (2, 2020, 2);
INSERT INTO teaches (id, year, semester) VALUES (3, 2020, 3);
INSERT INTO teaches (id, year, semester) VALUES (4, 2020, 4);
INSERT INTO teaches (id, year, semester) VALUES (5, 2020, 5);
INSERT INTO course (course_id, dept_name, credits) VALUES (1, 1, 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (2, 1, 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (3, 2, 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (4, 2, 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (5, 3, 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (6, 3, 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (7, 4, 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (8, 5, 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (9, 5, 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (10, 5, 3);
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
(1, 26)
(2, 26)
(3, 26)
(4, 26)
(5, 26)
*/