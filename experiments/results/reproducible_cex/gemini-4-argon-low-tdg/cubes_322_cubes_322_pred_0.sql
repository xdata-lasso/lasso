-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (1, 'Alice', '30', 'Boston');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (2, 'Bob', '30', 'Boston');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (3, 'Charlie', '25', 'Seattle');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (4, 'Diana', '40', 'Austin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age, hometown FROM teacher ORDER BY age, teacher.teacher_id NULLS LAST;

/*
Gold Result:
('25', 'Seattle')
('30', 'Boston')
('30', 'Boston')
('40', 'Austin')
*/

-- Prediction Query
SELECT Age, Hometown FROM teacher;

/*
Prediction Result:
('30', 'Boston')
('30', 'Boston')
('25', 'Seattle')
('40', 'Austin')
*/