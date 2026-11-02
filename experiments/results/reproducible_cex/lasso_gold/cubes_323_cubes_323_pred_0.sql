-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1004, 'Phillip Garcia', 'collection', 'Petersonberg');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1005, 'Kristina Baldwin', 'science', 'Robinsonshire');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM teacher ORDER BY name, teacher.teacher_id NULLS LAST;

/*
Gold Result:
('Kristina Baldwin',)
('Phillip Garcia',)
*/

-- Prediction Query
SELECT Name FROM teacher ORDER BY Age ASC, teacher.teacher_id NULLS LAST;

/*
Prediction Result:
('Phillip Garcia',)
('Kristina Baldwin',)
*/