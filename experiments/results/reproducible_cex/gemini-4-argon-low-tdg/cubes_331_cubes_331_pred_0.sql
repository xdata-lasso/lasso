-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, non-matching (where count matches a Teacher_ID from a DIFFERENT hometown), and ORDER BY hometown.
-- Hometown 'Zeta' has count 1, and Teacher_ID 1 is in 'Zeta' -> Matches.
-- Hometown 'Alpha' has count 2, and Teacher_ID 2 is in 'Alpha' -> Matches.
-- Hometown 'Beta' has count 2, Teacher_IDs are 10 and 20 -> Does not match, unless join condition LHS.hometown = RHS.hometown is omitted (since Teacher_ID 2 exists in 'Alpha').
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (1, 'Alice', '30', 'Zeta');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (2, 'Bob', '40', 'Alpha');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (5, 'Charlie', '35', 'Alpha');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (10, 'David', '50', 'Beta');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (20, 'Eve', '28', 'Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hometown FROM (SELECT LHS.hometown AS hometown, LHS.n AS n, RHS.name AS name, RHS.age AS age FROM (SELECT hometown, COUNT(*) AS n FROM teacher GROUP BY hometown) AS LHS INNER JOIN teacher AS RHS ON (LHS.n = RHS.teacher_id AND LHS.hometown = RHS.hometown)) ORDER BY hometown;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Hometown FROM teacher GROUP BY Hometown ORDER BY COUNT(*) DESC, Hometown NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/