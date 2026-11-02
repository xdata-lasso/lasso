-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (1068, 'remain', 'often');
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (1071, 'your', 'avoid');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1069, 'Joseph Obrien', 'development', 'Lake Larry');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1072, 'Joseph Obrien', 'end', 'North Matthew');
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (1068, 1069, 1070);
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (1071, 1072, 1073);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, course FROM (SELECT LHS.course_id AS course_id, LHS.teacher_id AS teacher_id, LHS.grade AS grade, LHS.name AS name, LHS.age AS age, LHS.hometown AS hometown, RHS.staring_date AS staring_date, RHS.course AS course FROM (SELECT LHS.course_id AS course_id, LHS.teacher_id AS teacher_id, LHS.grade AS grade, RHS.name AS name, RHS.age AS age, RHS.hometown AS hometown FROM course_arrange AS LHS INNER JOIN teacher AS RHS ON (LHS.teacher_id = RHS.teacher_id)) AS LHS INNER JOIN course AS RHS ON (LHS.course_id = RHS.course_id)) ORDER BY name, course NULLS LAST;

/*
Gold Result:
('Joseph Obrien', 'avoid')
('Joseph Obrien', 'often')
*/

-- Prediction Query
SELECT T3.Name, T2.Course FROM course_arrange AS T1 JOIN course AS T2 ON T1.Course_ID = T2.Course_ID JOIN teacher AS T3 ON T1.Teacher_ID = T3.Teacher_ID ORDER BY T3.Name, T1.course_id NULLS LAST, T1.teacher_id NULLS LAST, T1.grade NULLS LAST, T2.course_id NULLS LAST, T3.teacher_id NULLS LAST;

/*
Prediction Result:
('Joseph Obrien', 'often')
('Joseph Obrien', 'avoid')
*/