-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (10, NULL, '50', 'Miami');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (20, 'Zack', '45', 'Austin');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (5, 'Aaron', '29', 'Denver');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, NULL, '60', 'Portland');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM teacher ORDER BY name, teacher.teacher_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM teacher ORDER BY Age ASC, teacher.teacher_id NULLS LAST;

/*
Prediction Result:
('Aaron',)
('Zack',)
(None,)
(None,)
*/