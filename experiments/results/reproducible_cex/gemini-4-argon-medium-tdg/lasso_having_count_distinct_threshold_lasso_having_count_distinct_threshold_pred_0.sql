-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, dept_name TEXT, credits INTEGER);

CREATE TABLE department (dept_name TEXT PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (dept_name) VALUES ('CS');
INSERT INTO department (dept_name) VALUES ('Math');
INSERT INTO course (course_id, dept_name, credits) VALUES (101, 'CS', 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (102, 'CS', 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (103, 'CS', 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (104, 'CS', 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (201, 'Math', 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (202, 'Math', 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (203, 'Math', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 2;

/*
Gold Result:
('CS', 9)
*/

-- Prediction Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 5;

/*
Prediction Result:
*/