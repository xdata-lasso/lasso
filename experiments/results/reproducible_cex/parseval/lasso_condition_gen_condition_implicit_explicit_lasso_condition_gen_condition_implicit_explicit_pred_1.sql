-- Schema DDL
CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, dept TEXT);

CREATE TABLE enrollment (student_id INTEGER, course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id), FOREIGN KEY (student_id) REFERENCES student (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("id", "name") VALUES (1, 's_s_c6c33f');

INSERT INTO "student" ("id", "name") VALUES (3, 's_s_c6c33f');

INSERT INTO "student" ("id", "name") VALUES (2, '4');

-- Inserting into table: course --
INSERT INTO "course" ("id", "name", "dept") VALUES (1, 'Database', '5k5swwqcgs');

INSERT INTO "course" ("id", "name", "dept") VALUES (-2147483647, 'Database', '9n8');

INSERT INTO "course" ("id", "name", "dept") VALUES (3, 'Database', 'gu7v');

INSERT INTO "course" ("id", "name", "dept") VALUES (2, 'e4', 'hria2ypuzhs');

-- Inserting into table: enrollment --
INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (2, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 2, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (2, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 2, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (2, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 2, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, NULL);

INSERT INTO "enrollment" ("student_id", "course_id", "grade") VALUES (1, 1, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('4', 1.0)
('4', 1.0)
('4', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database';

/*
Prediction Result:
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('4', 1.0)
('4', 1.0)
('4', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', 1.0)
('s_s_c6c33f', None)
('s_s_c6c33f', 1.0)
*/