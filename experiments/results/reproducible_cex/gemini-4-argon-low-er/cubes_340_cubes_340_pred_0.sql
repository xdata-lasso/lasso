-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (1, '2023-01-01', 'Math');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (1, 'Bob', '40', 'NY');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (2, 'Alice', '35', 'LA');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (3, NULL, '50', 'SF');
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (1, 1, 1);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (1, 2, 1);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."teacher_id" AS "teacher_id", "LHS"."grade" AS "grade", "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."hometown" AS "hometown", "RHS"."staring_date" AS "staring_date", "RHS"."course" AS "course" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."teacher_id" AS "teacher_id", "LHS"."grade" AS "grade", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."hometown" AS "hometown" FROM "course_arrange" AS "LHS" INNER JOIN "teacher" AS "RHS" ON ("LHS"."teacher_id" = "RHS"."teacher_id")) AS "LHS" INNER JOIN "course" AS "RHS" ON ("LHS"."course_id" = "RHS"."course_id")) WHERE ("course" = 'Math') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT T3.Name FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID = T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID = T3.Teacher_ID WHERE T2.Course = 'Math';

/*
Prediction Result:
('Bob',)
('Alice',)
(None,)
*/