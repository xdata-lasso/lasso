-- Schema DDL
CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);

CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id), FOREIGN KEY (student_id) REFERENCES student (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO course (id, name, dept) VALUES (1, 'default1', 'CS'), (0, 'Database', 'default1'), (2, 'Database', NULL), (3, NULL, 'default2'), (4, 'default1', 'Database');
INSERT INTO student (id, name) VALUES (1, 'CS'), (0, 'Database'), (2, 'Database'), (3, 'default2'), (4, 'Database'), (5, 'Database'), (6, 'default2');
INSERT INTO enrollment (course_id, student_id, grade) VALUES (4, 1, 1.0), (3, 1, 1.0), (NULL, 4, 1.0), (2, 4, 1.0), (3, 4, 1.0), (NULL, 1, 0.0), (1, 3, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
('Database', 1.0)
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.dept = 'CS' AND NOT e.grade IS NULL;

/*
Prediction Result:
('default2', 0.0)
*/