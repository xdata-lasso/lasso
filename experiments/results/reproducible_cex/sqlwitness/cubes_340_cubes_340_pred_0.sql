-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO teacher (teacher_id, name, age, hometown) VALUES (0, 'default2', 'default1', NULL), (1, 'default1', 'default1', 'Math'), (2, NULL, 'Math', 'Math'), (3, NULL, 'default2', 'Math'), (4, NULL, 'default1', 'default1'), (5, NULL, 'Math', 'default2'), (6, 'Math', 'default2', NULL), (7, 'default2', NULL, 'default1'), (8, 'default1', 'Math', 'Math'), (9, 'default1', NULL, 'default1'), (10, 'default2', NULL, 'Math'), (11, 'default1', NULL, 'Math'), (12, NULL, 'default1', 'default2'), (13, 'Math', 'Math', 'Math'), (14, 'default1', 'default1', 'Math'), (15, 'default2', 'default2', 'default1');
INSERT INTO course (course_id, staring_date, course) VALUES (1, NULL, 'default1'), (0, 'default2', 'default1'), (2, 'default2', 'default2'), (3, NULL, 'default2'), (4, 'Math', 'default2'), (5, NULL, 'default2'), (6, NULL, 'default2'), (7, 'default1', 'default2'), (8, 'default1', 'Math'), (9, 'default1', NULL), (10, 'Math', 'default1'), (11, NULL, 'default2'), (12, NULL, 'Math'), (13, 'Math', 'Math'), (14, 'default1', 'default1'), (15, 'default1', NULL), (16, 'default1', 'default1'), (17, 'default1', 'Math'), (18, 'Math', 'default2'), (19, 'default2', NULL), (20, 'Math', 'Math'), (21, 'default1', 'default2');
INSERT INTO course_arrange (course_id, teacher_id, grade) VALUES (17, 1, 1), (2, 7, 0), (13, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."teacher_id" AS "teacher_id", "LHS"."grade" AS "grade", "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."hometown" AS "hometown", "RHS"."staring_date" AS "staring_date", "RHS"."course" AS "course" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."teacher_id" AS "teacher_id", "LHS"."grade" AS "grade", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."hometown" AS "hometown" FROM "course_arrange" AS "LHS" INNER JOIN "teacher" AS "RHS" ON ("LHS"."teacher_id" = "RHS"."teacher_id")) AS "LHS" INNER JOIN "course" AS "RHS" ON ("LHS"."course_id" = "RHS"."course_id")) WHERE ("course" = 'Math') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT T3.Name FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID = T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID = T3.Teacher_ID WHERE T2.Course = 'Math';

/*
Prediction Result:
('default1',)
(None,)
*/