-- Schema DDL
CREATE TABLE Student (student_id INTEGER PRIMARY KEY, student_name TEXT);

CREATE TABLE Enrollment (student_id INTEGER, course_code TEXT, semester TEXT, FOREIGN KEY (student_id) REFERENCES Student (student_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("student_id", "student_name") VALUES (1007, 'Donald Lewis');
INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1007, 'CS101', 'source');
INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1007, 'CS101', 'great');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student.student_id FROM student INNER JOIN enrollment ON student.student_id = enrollment.student_id WHERE enrollment.course_code = 'CS101';

/*
Gold Result:
(1007,)
(1007,)
*/

-- Prediction Query
SELECT student_id FROM student INTERSECT SELECT student_id FROM enrollment WHERE course_code = 'CS101';

/*
Prediction Result:
(1007,)
*/