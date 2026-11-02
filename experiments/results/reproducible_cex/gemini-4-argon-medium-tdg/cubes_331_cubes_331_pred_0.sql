-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join conditions, ordering (Zebra vs Alpha), and partial matches.
-- "Zebra" has count 2 and a teacher with ID 2 in "Zebra" (Match).
-- "Alpha" has count 3 and a teacher with ID 3 in "Alpha" (Match).
-- "Beta" has count 1, and a teacher with ID 1 exists, but in "Alpha" (Tests LHS.hometown = RHS.hometown).
-- "Gamma" has count 1, and its teacher has ID 99 (Tests LHS.n = RHS.teacher_id).
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (2, 'Alice', '30', 'Zebra');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (10, 'Bob', '40', 'Zebra');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, 'Charlie', '25', 'Alpha');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (3, 'David', '35', 'Alpha');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (11, 'Eve', '28', 'Alpha');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (12, 'Frank', '50', 'Beta');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (99, 'Grace', '45', 'Gamma');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hometown FROM (SELECT LHS.hometown AS hometown, LHS.n AS n, RHS.name AS name, RHS.age AS age FROM (SELECT hometown, COUNT(*) AS n FROM teacher GROUP BY hometown) AS LHS INNER JOIN teacher AS RHS ON (LHS.n = RHS.teacher_id AND LHS.hometown = RHS.hometown)) ORDER BY hometown;

/*
Gold Result:
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT Hometown FROM teacher GROUP BY Hometown ORDER BY COUNT(*) DESC, Hometown NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/