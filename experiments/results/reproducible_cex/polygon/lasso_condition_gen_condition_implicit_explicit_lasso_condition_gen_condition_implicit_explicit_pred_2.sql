-- Schema DDL
CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);

CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id), FOREIGN KEY (student_id) REFERENCES student (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("id", "name") VALUES (19, 'Database31');
INSERT INTO "student" ("id", "name") VALUES (31, 'Database30');
INSERT INTO "course" ("id", "name", "dept") VALUES (21, 'Database31', 'Database31');
INSERT INTO "course" ("id", "name", "dept") VALUES (20, 'Database28', 'Database');
INSERT INTO "enrollment" ("course_id", "student_id", "grade") VALUES (NULL, NULL, 31);
INSERT INTO "enrollment" ("course_id", "student_id", "grade") VALUES (20, 31, 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.dept = 'Database' AND NOT e.grade IS NULL;

/*
Prediction Result:
('Database30', 32.0)
*/