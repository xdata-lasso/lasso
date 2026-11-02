-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Deduplication by Name vs Teacher_ID (Teachers 1 and 2 have the same Name 'Alice', testing if GROUP BY Teacher_ID or missing DISTINCT is used).
-- 2. Ordering mismatch (Insertion order: Zara, Alice, Bob; Age order: 45, 22, 30, 50; Hometown order: Paris, Boston, London, Austin).
-- 3. Unassigned teachers (Teachers 2 and 4 are not in course_arrange, catching false INNER JOINs with course_arrange).
-- 4. Duplicate assignments (Teacher 1 has multiple rows in course_arrange, catching false JOINs without DISTINCT).
-- 5. Table confusion (Course names are 'Physics' and 'Math', catching queries selecting from course instead of teacher).
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (101, '2023-09-01', 'Physics');
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (102, '2023-09-02', 'Math');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (1, 'Zara', '30', 'London');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (2, 'Alice', '45', 'Boston');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (3, 'Bob', '22', 'Paris');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (4, 'Alice', '50', 'Austin');
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (101, 1, 1);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (102, 1, 2);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (101, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name FROM teacher INTERSECT SELECT name FROM teacher) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Zara',)
*/

-- Prediction Query
SELECT name FROM teacher WHERE hometown <> 'little lever urban district';

/*
Prediction Result:
('Zara',)
('Alice',)
('Bob',)
('Alice',)
*/