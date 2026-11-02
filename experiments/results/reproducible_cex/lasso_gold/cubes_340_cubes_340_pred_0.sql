-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (1042, 'high', 'Math');
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (1048, 'traditional', 'Math');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1043, 'Zachary Hicks', 'benefit', 'Port Danielburgh');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1049, 'Melanie Wilson', 'value', 'Kaylamouth');
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (1042, 1043, 1044);
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (1042, 1043, 1047);
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (1048, 1049, 1050);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."teacher_id" AS "teacher_id", "LHS"."grade" AS "grade", "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."hometown" AS "hometown", "RHS"."staring_date" AS "staring_date", "RHS"."course" AS "course" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."teacher_id" AS "teacher_id", "LHS"."grade" AS "grade", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."hometown" AS "hometown" FROM "course_arrange" AS "LHS" INNER JOIN "teacher" AS "RHS" ON ("LHS"."teacher_id" = "RHS"."teacher_id")) AS "LHS" INNER JOIN "course" AS "RHS" ON ("LHS"."course_id" = "RHS"."course_id")) WHERE ("course" = 'Math') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Melanie Wilson',)
('Zachary Hicks',)
('Zachary Hicks',)
*/

-- Prediction Query
SELECT T3.Name FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID = T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID = T3.Teacher_ID WHERE T2.Course = 'Math';

/*
Prediction Result:
('Zachary Hicks',)
('Zachary Hicks',)
('Melanie Wilson',)
*/