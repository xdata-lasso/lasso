-- Schema DDL
CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);

CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id), FOREIGN KEY (student_id) REFERENCES student (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO course (id, name, dept) VALUES (1, 'Database', 'default1'), (0, 'Database', 'default2');
INSERT INTO student (id, name) VALUES (0, 'Database'), (1, 'default1'), (2, 'default1'), (3, NULL), (4, 'default2'), (5, 'default2');
INSERT INTO enrollment (course_id, student_id, grade) VALUES (0, NULL, 0.0), (0, 3, 0.0), (1, 1, NULL), (NULL, 4, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
(None, 0.0)
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.dept = 'Database' AND NOT e.grade IS NULL;

/*
Prediction Result:
*/