-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO teacher (teacher_id, name, age, hometown) VALUES (0, 'default2', 'little lever urban district', 'default2'), (1, NULL, 'default1', NULL), (2, 'default2', 'little lever urban district', 'default1'), (3, 'default2', 'little lever urban district', 'default2'), (4, NULL, 'default2', 'default1'), (5, NULL, NULL, 'little lever urban district');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name FROM teacher INTERSECT SELECT name FROM teacher) ORDER BY name;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT name FROM teacher WHERE hometown <> 'little lever urban district';

/*
Prediction Result:
('default2',)
('default2',)
('default2',)
(None,)
*/