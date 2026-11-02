-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO teacher (teacher_id, name, age, hometown) VALUES (0, 'default2', 'default2', 'default1'), (1, 'default1', NULL, NULL);
INSERT INTO course (course_id, staring_date, course) VALUES (0, NULL, 'default2'), (1, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM teacher AS LHS WHERE NOT EXISTS(SELECT 1 FROM course_arrange AS RHS WHERE (LHS.teacher_id = RHS.teacher_id))) ORDER BY name;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM teacher WHERE NOT Teacher_id IN (SELECT Teacher_id FROM course_arrange);

/*
Prediction Result:
('default2',)
('default1',)
*/