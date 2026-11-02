-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, dept_name TEXT, credits INTEGER);

CREATE TABLE department (dept_name TEXT PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (dept_name) VALUES ('CS');
INSERT INTO department (dept_name) VALUES ('Math');
INSERT INTO department (dept_name) VALUES ('History');
INSERT INTO department (dept_name) VALUES ('Physics');
INSERT INTO department (dept_name) VALUES ('Art');
INSERT INTO course (course_id, dept_name, credits) VALUES (1, 'CS', 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (2, 'CS', 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (3, 'CS', 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (4, 'Math', 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (5, 'Math', 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (6, 'Math', 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (7, 'History', 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (8, 'History', 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (9, 'History', 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (10, 'Physics', 1);
INSERT INTO course (course_id, dept_name, credits) VALUES (11, 'Physics', 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (12, 'Physics', 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (13, 'Physics', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 2;

/*
Gold Result:
('History', 6)
('Physics', 9)
*/

-- Prediction Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 5;

/*
Prediction Result:
*/