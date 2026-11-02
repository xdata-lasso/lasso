-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (1, '2023-09-01', 'Database Systems');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM teacher ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM teacher;

/*
Prediction Result:
(0,)
*/