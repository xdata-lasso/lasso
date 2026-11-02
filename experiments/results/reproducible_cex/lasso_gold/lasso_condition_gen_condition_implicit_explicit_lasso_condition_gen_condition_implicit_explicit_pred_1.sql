-- Schema DDL
CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);

CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id), FOREIGN KEY (student_id) REFERENCES student (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("id", "name", "dept") VALUES (1053, 'Database', 'rise');
INSERT INTO "course" ("id", "name", "dept") VALUES (1059, 'Database', 'our');
INSERT INTO "student" ("id", "name") VALUES (1054, 'Melinda Cameron');
INSERT INTO "student" ("id", "name") VALUES (1060, 'Emily Rios');
INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1054, 1053, 1055.5);
INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1060, 1059, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
('Melinda Cameron', 1055.5)
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database';

/*
Prediction Result:
('Melinda Cameron', 1055.5)
('Emily Rios', None)
*/