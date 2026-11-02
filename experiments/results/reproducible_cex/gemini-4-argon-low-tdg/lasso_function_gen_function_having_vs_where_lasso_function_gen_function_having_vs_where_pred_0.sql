-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE enrollment (course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests HAVING vs WHERE (individual grades <= 85 and > 85), exact boundary (85.0), and ROUND(..., 2) precision
INSERT INTO course (id, name) VALUES (1, 'Course_Pass');
INSERT INTO course (id, name) VALUES (2, 'Course_Boundary');
INSERT INTO course (id, name) VALUES (3, 'Course_Fail');
INSERT INTO enrollment (course_id, grade) VALUES (1, 80.0);
INSERT INTO enrollment (course_id, grade) VALUES (1, 90.0);
INSERT INTO enrollment (course_id, grade) VALUES (1, 90.0);
INSERT INTO enrollment (course_id, grade) VALUES (2, 85.0);
INSERT INTO enrollment (course_id, grade) VALUES (2, 85.0);
INSERT INTO enrollment (course_id, grade) VALUES (3, 70.0);
INSERT INTO enrollment (course_id, grade) VALUES (3, 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, ROUND(AVG(e.grade), 2) FROM course AS c JOIN enrollment AS e ON c.id = e.course_id GROUP BY c.name HAVING AVG(e.grade) > 85;

/*
Gold Result:
('Course_Pass', 86.67)
*/

-- Prediction Query
SELECT c.name, ROUND(AVG(e.grade), 2) FROM course AS c JOIN enrollment AS e ON c.id = e.course_id GROUP BY c.name;

/*
Prediction Result:
('Course_Boundary', 85.0)
('Course_Fail', 80.0)
('Course_Pass', 86.67)
*/