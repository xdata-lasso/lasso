-- Schema DDL
CREATE TABLE department (dept_name INTEGER, building INTEGER, budget INTEGER);

CREATE TABLE teaches (id INTEGER, year INTEGER, semester INTEGER);

CREATE TABLE course (course_id INTEGER, dept_name INTEGER, credits INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 104);
INSERT INTO department (dept_name, building, budget) VALUES (2, 20, 204);
INSERT INTO department (dept_name, building, budget) VALUES (3, 30, 304);
INSERT INTO department (dept_name, building, budget) VALUES (4, 40, 404);
INSERT INTO department (dept_name, building, budget) VALUES (5, 50, 504);
INSERT INTO teaches (id, year, semester) VALUES (1, 100, 10);
INSERT INTO teaches (id, year, semester) VALUES (2, 200, 20);
INSERT INTO teaches (id, year, semester) VALUES (3, 300, 30);
INSERT INTO teaches (id, year, semester) VALUES (4, 400, 40);
INSERT INTO teaches (id, year, semester) VALUES (5, 500, 40);
INSERT INTO course (course_id, dept_name, credits) VALUES (101, 1, 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (102, 1, 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (201, 2, 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (202, 2, 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (301, 3, 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (401, 4, 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (402, 4, 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (501, 5, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.semester, SUM(C.credits) FROM department AS D INNER JOIN teaches AS T ON D.budget = T.year + 4 INNER JOIN course AS C ON C.dept_name = D.dept_name GROUP BY T.semester HAVING AVG(C.credits) > 2 AND COUNT(D.building) = 2;

/*
Gold Result:
(10, 6)
*/

-- Prediction Query
SELECT T.semester, SUM(C.credits) FROM department AS D INNER JOIN teaches AS T ON D.budget = T.year + 4 INNER JOIN course AS C ON C.dept_name = D.dept_name GROUP BY T.semester HAVING AVG(C.credits) > 2 AND COUNT(D.building) >= 2;

/*
Prediction Result:
(10, 6)
(40, 12)
*/