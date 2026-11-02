-- Schema DDL
CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);

CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id), FOREIGN KEY (student_id) REFERENCES student (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO student (id, name) VALUES (1, 'Alice');
INSERT INTO student (id, name) VALUES (2, 'Bob');
INSERT INTO student (id, name) VALUES (3, 'Charlie');
INSERT INTO student (id, name) VALUES (4, 'Database');
INSERT INTO student (id, name) VALUES (5, NULL);
INSERT INTO course (id, name, dept) VALUES (10, 'Database', 'CS');
INSERT INTO course (id, name, dept) VALUES (20, 'Algorithms', 'Database');
INSERT INTO course (id, name, dept) VALUES (30, 'Database Systems', 'CS');
INSERT INTO course (id, name, dept) VALUES (40, 'database', 'CS');
INSERT INTO course (id, name, dept) VALUES (50, NULL, 'CS');
INSERT INTO enrollment (student_id, course_id, grade) VALUES (1, 10, 95.5);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (2, 10, NULL);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (3, 10, 0.0);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (4, 20, 88.0);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (1, 30, 92.0);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (1, 40, 85.0);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (1, 50, 75.0);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (5, 10, 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
('Alice', 95.5)
('Charlie', 0.0)
(None, 80.0)
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND e.grade IS NULL;

/*
Prediction Result:
('Bob', None)
*/