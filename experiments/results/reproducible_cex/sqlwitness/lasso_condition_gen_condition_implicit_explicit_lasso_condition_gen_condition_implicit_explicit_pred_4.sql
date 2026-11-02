-- Schema DDL
CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);

CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id), FOREIGN KEY (student_id) REFERENCES student (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO course (id, name, dept) VALUES (0, 'default2', 'Database');
INSERT INTO student (id, name) VALUES (0, 'default2'), (1, 'default2'), (2, 'Database'), (3, 'Database');
INSERT INTO enrollment (course_id, student_id, grade) VALUES (0, 1, 0.0), (NULL, 2, NULL), (NULL, 3, 0.0), (NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE NOT e.grade IS NULL;

/*
Prediction Result:
('default2', 0.0)
*/