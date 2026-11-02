-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1002, 'Kimberly Garza', 'almost', 'North Jefferyhaven');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1003, 'Kimberly Garza', 'almost', 'North Jefferyhaven');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name FROM teacher INTERSECT SELECT name FROM teacher) ORDER BY name;

/*
Gold Result:
('Kimberly Garza',)
*/

-- Prediction Query
SELECT name FROM teacher WHERE hometown <> 'little lever urban district';

/*
Prediction Result:
('Kimberly Garza',)
('Kimberly Garza',)
*/