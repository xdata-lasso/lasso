-- Schema DDL
CREATE TABLE Student (student_id INTEGER PRIMARY KEY, student_name TEXT);

CREATE TABLE Enrollment (student_id INTEGER, course_code TEXT, semester TEXT, FOREIGN KEY (student_id) REFERENCES Student (student_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (student_id, student_name) VALUES (1, 'Alice');
INSERT INTO Enrollment (student_id, course_code, semester) VALUES (1, 'CS101', 'Fall');
INSERT INTO Enrollment (student_id, course_code, semester) VALUES (1, 'CS101', 'Spring');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student.student_id FROM student INNER JOIN enrollment ON student.student_id = enrollment.student_id WHERE enrollment.course_code = 'CS101';

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT student_id FROM student INTERSECT SELECT student_id FROM enrollment WHERE course_code = 'CS101';

/*
Prediction Result:
(1,)
*/