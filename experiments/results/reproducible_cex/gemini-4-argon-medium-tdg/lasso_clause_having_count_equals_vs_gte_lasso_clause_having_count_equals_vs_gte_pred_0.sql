-- Schema DDL
CREATE TABLE department (dept_name INTEGER, building INTEGER, budget INTEGER);

CREATE TABLE teaches (id INTEGER, year INTEGER, semester INTEGER);

CREATE TABLE course (course_id INTEGER, dept_name INTEGER, credits INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 2004);
INSERT INTO department (dept_name, building, budget) VALUES (2, 20, 2005);
INSERT INTO department (dept_name, building, budget) VALUES (3, 30, 2006);
INSERT INTO department (dept_name, building, budget) VALUES (4, 40, 2007);
INSERT INTO teaches (id, year, semester) VALUES (1, 2000, 1);
INSERT INTO teaches (id, year, semester) VALUES (2, 2001, 2);
INSERT INTO teaches (id, year, semester) VALUES (3, 2002, 3);
INSERT INTO teaches (id, year, semester) VALUES (4, 2003, 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (101, 1, 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (102, 1, 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (201, 2, 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (202, 2, 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (301, 3, 5);
INSERT INTO course (course_id, dept_name, credits) VALUES (401, 4, 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (402, 4, 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (403, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.semester, SUM(C.credits) FROM department AS D INNER JOIN teaches AS T ON D.budget = T.year + 4 INNER JOIN course AS C ON C.dept_name = D.dept_name GROUP BY T.semester HAVING AVG(C.credits) > 2 AND COUNT(D.building) = 2;

/*
Gold Result:
(1, 7)
*/

-- Prediction Query
SELECT T.semester, SUM(C.credits) FROM department AS D INNER JOIN teaches AS T ON D.budget = T.year + 4 INNER JOIN course AS C ON C.dept_name = D.dept_name GROUP BY T.semester HAVING AVG(C.credits) > 2 AND COUNT(D.building) >= 2;

/*
Prediction Result:
(1, 7)
(4, 9)
*/