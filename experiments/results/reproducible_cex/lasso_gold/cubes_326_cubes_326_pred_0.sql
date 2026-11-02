-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (1001, 'purpose', 'site');
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (1002, 'brother', 'face');
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (1003, 'ago', 'election');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1, 'Noah Rhodes', 'agreement', 'Robinsonshire');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (3, 'Angie Henderson', 'option', 'Lisatown');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1004, 'Daniel Wagner', 'decide', 'Lake Roberto');
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (1001, 1, 1005);
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (1002, 1, 1006);
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (1003, 1, 1007);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT teacher_id, name, age, hometown, course_id, teacher_id_other, grade, teacher_id AS n FROM (SELECT LHS.teacher_id AS teacher_id, LHS.name AS name, LHS.age AS age, LHS.hometown AS hometown, RHS.course_id AS course_id, RHS.teacher_id AS teacher_id_other, RHS.grade AS grade FROM teacher AS LHS INNER JOIN (SELECT course_id, teacher_id, grade, COUNT(*) OVER () AS n FROM course_arrange) AS RHS ON (LHS.teacher_id = RHS.n))) WHERE (n > 2) ORDER BY name;

/*
Gold Result:
('Angie Henderson',)
*/

-- Prediction Query
SELECT T2.Name FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.Teacher_ID = T2.Teacher_ID GROUP BY T2.Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Noah Rhodes',)
*/