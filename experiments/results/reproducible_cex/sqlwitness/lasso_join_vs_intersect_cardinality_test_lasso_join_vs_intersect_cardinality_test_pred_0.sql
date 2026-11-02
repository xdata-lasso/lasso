-- Schema DDL
CREATE TABLE Student (student_id INTEGER PRIMARY KEY, student_name TEXT);

CREATE TABLE Enrollment (student_id INTEGER, course_code TEXT, semester TEXT, FOREIGN KEY (student_id) REFERENCES Student (student_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO student (student_id, student_name) VALUES (0, 'default1'), (1, NULL), (2, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'default2'), (6, 'CS101'), (7, NULL), (8, NULL), (9, NULL), (10, NULL), (11, 'default2'), (12, 'default1');
INSERT INTO enrollment (student_id, course_code, semester) VALUES (3, 'default2', 'default1'), (9, NULL, 'CS101'), (3, 'default2', NULL), (0, 'CS101', 'default2'), (NULL, 'default2', 'CS101'), (3, NULL, NULL), (10, 'CS101', 'default1'), (3, 'default1', 'CS101'), (5, 'default1', 'CS101'), (6, 'CS101', NULL), (7, NULL, 'default2'), (0, 'default2', 'default2'), (2, NULL, 'default1'), (4, 'default1', 'default2'), (10, NULL, 'default1'), (0, 'CS101', 'default1'), (8, 'CS101', 'default2'), (7, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student.student_id FROM student INNER JOIN enrollment ON student.student_id = enrollment.student_id WHERE enrollment.course_code = 'CS101';

/*
Gold Result:
(0,)
(10,)
(6,)
(0,)
(8,)
*/

-- Prediction Query
SELECT student_id FROM student INTERSECT SELECT student_id FROM enrollment WHERE course_code = 'CS101';

/*
Prediction Result:
(0,)
(6,)
(8,)
(10,)
*/