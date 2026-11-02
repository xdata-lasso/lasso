-- Schema DDL
CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);

CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id), FOREIGN KEY (student_id) REFERENCES student (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO course (id, name, dept) VALUES (0, 'default1', NULL), (1, NULL, NULL), (2, 'default1', 'Database'), (3, 'default2', 'Database'), (4, NULL, 'default2'), (5, 'Database', 'Database'), (6, NULL, 'Database'), (7, 'Database', NULL);
INSERT INTO student (id, name) VALUES (1, NULL);
INSERT INTO enrollment (course_id, student_id, grade) VALUES (7, NULL, 1.0), (2, 1, NULL), (6, NULL, 1.0), (3, 1, NULL), (2, 1, 0.0), (7, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database';

/*
Prediction Result:
(None, None)
*/