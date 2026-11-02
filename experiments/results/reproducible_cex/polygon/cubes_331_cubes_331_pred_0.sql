-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (10, '9', '9');
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (9, '9', '9');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (12, '9', '9', '14');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (11, '9', '9', NULL);
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (9, 12, 9);
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (9, 11, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hometown FROM (SELECT LHS.hometown AS hometown, LHS.n AS n, RHS.name AS name, RHS.age AS age FROM (SELECT hometown, COUNT(*) AS n FROM teacher GROUP BY hometown) AS LHS INNER JOIN teacher AS RHS ON (LHS.n = RHS.teacher_id AND LHS.hometown = RHS.hometown)) ORDER BY hometown;

/*
Gold Result:
*/

-- Prediction Query
SELECT Hometown FROM teacher GROUP BY Hometown ORDER BY COUNT(*) DESC, Hometown NULLS LAST LIMIT 1;

/*
Prediction Result:
('14',)
*/