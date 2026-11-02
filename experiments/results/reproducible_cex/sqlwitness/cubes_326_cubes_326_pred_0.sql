-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO teacher (teacher_id, name, age, hometown) VALUES (2, NULL, NULL, 'default2'), (0, 'default1', NULL, NULL), (1, 'default1', NULL, 'default1'), (3, NULL, 'default1', 'default1');
INSERT INTO course (course_id, staring_date, course) VALUES (1, 'default2', NULL), (0, NULL, 'default2'), (3, 'default2', 'default2'), (2, NULL, 'default2'), (4, NULL, 'default2'), (5, NULL, NULL), (6, 'default2', NULL);
INSERT INTO course_arrange (course_id, teacher_id, grade) VALUES (4, 2, 2), (6, 0, 1), (4, 1, 3), (5, 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT teacher_id, name, age, hometown, course_id, teacher_id_other, grade, teacher_id AS n FROM (SELECT LHS.teacher_id AS teacher_id, LHS.name AS name, LHS.age AS age, LHS.hometown AS hometown, RHS.course_id AS course_id, RHS.teacher_id AS teacher_id_other, RHS.grade AS grade FROM teacher AS LHS INNER JOIN (SELECT course_id, teacher_id, grade, COUNT(*) OVER () AS n FROM course_arrange) AS RHS ON (LHS.teacher_id = RHS.n))) WHERE (n > 2) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Name FROM course_arrange AS T1 JOIN teacher AS T2 ON T1.Teacher_ID = T2.Teacher_ID GROUP BY T2.Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('default1',)
*/