-- Schema DDL
CREATE TABLE Student (student_id INTEGER PRIMARY KEY, student_name TEXT);

CREATE TABLE Enrollment (student_id INTEGER, course_code TEXT, semester TEXT, FOREIGN KEY (student_id) REFERENCES Student (student_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("student_id", "student_name") VALUES (1, '5k5swwqcgs');

INSERT INTO "student" ("student_id", "student_name") VALUES (2, '4');

INSERT INTO "student" ("student_id", "student_name") VALUES (3, 'gu7v');

-- Inserting into table: enrollment --
INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'CS101', '9n8');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (3, 'CS101', 'e4');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (3, 'CS101', 'hria2ypuzhs');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (3, 'CS101', 'rwbbp6luhvd');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'CS101', 'tti');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'CS101', 'bnp');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'CS101', 'mdpos');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'CS101', 'ie5');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'CS101', 'nw6klf');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'CS101', 'a9000t5c4eci');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'enr_3ee520', 'gce376nium52');

INSERT INTO "enrollment" ("student_id", "course_code", "semester") VALUES (1, 'CS101', 'zbuo4nrqrof');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student.student_id FROM student INNER JOIN enrollment ON student.student_id = enrollment.student_id WHERE enrollment.course_code = 'CS101';

/*
Gold Result:
(1,)
(3,)
(3,)
(3,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT student_id FROM student INTERSECT SELECT student_id FROM enrollment WHERE course_code = 'CS101';

/*
Prediction Result:
(1,)
(3,)
*/