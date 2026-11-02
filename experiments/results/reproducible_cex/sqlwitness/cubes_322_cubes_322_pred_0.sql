-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO teacher (teacher_id, name, age, hometown) VALUES (1, 'default2', NULL, 'default1'), (0, NULL, 'default2', 'default1'), (2, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age, hometown FROM teacher ORDER BY age, teacher.teacher_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, 'default2')
('default2', 'default1')
*/

-- Prediction Query
SELECT Age, Hometown FROM teacher;

/*
Prediction Result:
('default2', 'default1')
(None, 'default1')
(None, 'default2')
*/