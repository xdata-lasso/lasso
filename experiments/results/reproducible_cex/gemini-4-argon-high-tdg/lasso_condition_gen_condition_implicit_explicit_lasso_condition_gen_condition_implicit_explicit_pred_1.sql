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
INSERT INTO student (id, name) VALUES (4, 'Diana');
INSERT INTO course (id, name, dept) VALUES (101, 'Database', 'CS');
INSERT INTO course (id, name, dept) VALUES (102, 'Algorithms', 'CS');
INSERT INTO course (id, name, dept) VALUES (103, 'Calculus', 'Math');
INSERT INTO enrollment (student_id, course_id, grade) VALUES (1, 101, 92.5);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (2, 101, NULL);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (3, 102, 88.0);
INSERT INTO enrollment (student_id, course_id, grade) VALUES (1, 102, 79.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
('Alice', 92.5)
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database';

/*
Prediction Result:
('Alice', 92.5)
('Bob', None)
*/