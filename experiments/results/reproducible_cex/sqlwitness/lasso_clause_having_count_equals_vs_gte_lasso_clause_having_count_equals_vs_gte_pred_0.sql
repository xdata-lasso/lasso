-- Schema DDL
CREATE TABLE department (dept_name INTEGER, building INTEGER, budget INTEGER);

CREATE TABLE teaches (id INTEGER, year INTEGER, semester INTEGER);

CREATE TABLE course (course_id INTEGER, dept_name INTEGER, credits INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO course (course_id, dept_name, credits) VALUES (1, 1, 0), (NULL, 4, NULL), (NULL, 5, NULL), (NULL, 1, 2), (2, 2, 0), (5, 5, 0), (5, 0, 2), (3, 2, 4), (3, 1, 0), (0, 0, NULL), (1, NULL, 1), (5, 0, 4);
INSERT INTO teaches (id, year, semester) VALUES (1, 0, 3), (2, 2, NULL), (3, 3, 1), (NULL, 4, NULL), (0, 1, 2), (NULL, NULL, 3), (4, 3, 5), (5, 3, 4), (1, 2, 2), (NULL, 2, 4), (3, 2, 2), (1, 1, NULL), (1, 0, 3);
INSERT INTO department (dept_name, building, budget) VALUES (3, 1, NULL), (2, 4, 1), (4, 1, 0), (0, 4, 5), (0, 5, 4), (0, 4, 1);
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
(None, 6)
(2, 6)
(3, 12)
*/