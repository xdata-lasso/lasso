-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering on Course = 'Math', ORDER BY Name, and NULLS LAST behavior.
-- Also tests exclusion of unmatched teachers and courses (INNER JOIN vs LEFT/RIGHT JOIN).
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (1, '2023-09-01', 'Math');
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (2, '2023-09-02', 'Science');
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (3, '2023-09-03', 'Math');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (10, 'Zack', '45', 'Boston');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (20, 'Alice', '30', 'Austin');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (30, NULL, '50', 'Chicago');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (40, 'Bob', '35', 'Denver');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (50, 'Unassigned', '28', 'Miami');
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (1, 10, 1);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (1, 20, 2);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (1, 30, 3);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (2, 40, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."teacher_id" AS "teacher_id", "LHS"."grade" AS "grade", "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."hometown" AS "hometown", "RHS"."staring_date" AS "staring_date", "RHS"."course" AS "course" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."teacher_id" AS "teacher_id", "LHS"."grade" AS "grade", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."hometown" AS "hometown" FROM "course_arrange" AS "LHS" INNER JOIN "teacher" AS "RHS" ON ("LHS"."teacher_id" = "RHS"."teacher_id")) AS "LHS" INNER JOIN "course" AS "RHS" ON ("LHS"."course_id" = "RHS"."course_id")) WHERE ("course" = 'Math') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T3.Name FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID = T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID = T3.Teacher_ID WHERE T2.Course = 'Math';

/*
Prediction Result:
('Zack',)
('Alice',)
(None,)
*/