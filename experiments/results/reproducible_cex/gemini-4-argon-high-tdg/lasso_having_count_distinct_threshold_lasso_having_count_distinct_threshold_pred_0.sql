-- Schema DDL
CREATE TABLE course (course_id INTEGER PRIMARY KEY, dept_name TEXT, credits INTEGER);

CREATE TABLE department (dept_name TEXT PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (dept_name) VALUES ('CS');
INSERT INTO department (dept_name) VALUES ('Math');
INSERT INTO department (dept_name) VALUES ('Physics');
INSERT INTO department (dept_name) VALUES ('History');
INSERT INTO course (course_id, dept_name, credits) VALUES (101, 'CS', 2);
INSERT INTO course (course_id, dept_name, credits) VALUES (102, 'CS', 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (103, 'CS', 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (104, 'CS', 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (201, 'Math', 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (202, 'Math', 3);
INSERT INTO course (course_id, dept_name, credits) VALUES (203, 'Math', 4);
INSERT INTO course (course_id, dept_name, credits) VALUES (301, 'Physics', 5);
INSERT INTO course (course_id, dept_name, credits) VALUES (302, 'Physics', 5);
INSERT INTO course (course_id, dept_name, credits) VALUES (303, 'Physics', 5);
INSERT INTO course (course_id, dept_name, credits) VALUES (304, 'Physics', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 2;

/*
Gold Result:
('CS', 13)
*/

-- Prediction Query
SELECT c.dept_name, SUM(c.credits) FROM course AS c INNER JOIN department AS d ON c.dept_name = d.dept_name GROUP BY c.dept_name HAVING COUNT(DISTINCT c.credits) > 5;

/*
Prediction Result:
*/