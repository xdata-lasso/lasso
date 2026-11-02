-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (1, '2023-01-01', 'Math');
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (2, '2023-02-01', 'Physics');
INSERT INTO "course" ("Course_ID", "Staring_Date", "Course") VALUES (3, '2023-03-01', 'Chemistry');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (1, 'Alice', '35', 'NY');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (2, 'Bob', '40', 'LA');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (3, 'Charlie', '45', 'SF');
INSERT INTO "teacher" ("Teacher_ID", "Name", "Age", "Hometown") VALUES (4, 'David', '50', 'TX');
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (1, 1, 1);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (2, 1, 2);
INSERT INTO "course_arrange" ("Course_ID", "Teacher_ID", "Grade") VALUES (3, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT teacher_id, name, age, hometown, course_id, teacher_id_other, grade, teacher_id AS n FROM (SELECT LHS.teacher_id AS teacher_id, LHS.name AS name, LHS.age AS age, LHS.hometown AS hometown, RHS.course_id AS course_id, RHS.teacher_id AS teacher_id_other, RHS.grade AS grade FROM teacher AS LHS INNER JOIN (SELECT course_id, teacher_id, grade, COUNT(*) OVER () AS n FROM course_arrange) AS RHS ON (LHS.teacher_id = RHS.n))) WHERE (n > 2) ORDER BY name;

/*
Gold Result:
('Charlie',)
*/

-- Prediction Query
SELECT T2.Name FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.Teacher_ID = T2.Teacher_ID GROUP BY T2.Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Alice',)
*/