-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Teacher_ID, duplicate removal (SELECT DISTINCT mutants), and NULL handling in Name and Teacher_ID.
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (3, 'Alice', '30', 'NYC');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (1, 'Bob', '40', 'LA');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (2, 'Alice', '25', 'Boston');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (4, NULL, '50', 'Chicago');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (NULL, 'Alice', '35', 'Miami');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM teacher ORDER BY name, teacher.teacher_id NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM teacher ORDER BY Age ASC, teacher.teacher_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Alice',)
('Alice',)
('Bob',)
(None,)
*/