-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard anti-join, ordering, duplicate names, and join key mismatches (Course_ID vs Teacher_ID)
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (1, '2023-09-01', 'Math');
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (2, '2023-09-02', 'Physics');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (1, 'Zack', '45', 'Boston');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (2, 'Alice', '30', 'New York');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (3, 'Bob', '50', 'Chicago');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (4, 'Alice', '28', 'Seattle');
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (1, 3, 10);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (2, 3, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM teacher AS LHS WHERE NOT EXISTS(SELECT 1 FROM course_arrange AS RHS WHERE (LHS.teacher_id = RHS.teacher_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM teacher WHERE NOT Teacher_id IN (SELECT Teacher_id FROM course_arrange);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/