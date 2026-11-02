-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course --
INSERT INTO "course" ("course_id", "staring_date", "course") VALUES (-2147483648, '4', 'gu7v');

-- Inserting into table: teacher --
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1, 't2__bb98a2', '5k5swwqcgs', '9n8');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (2, 't2__bb98a2', '4h', 'ia2yp');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483647, 't2__bb98a2', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (4, 'posiie5unw6k', 'fa9', '00t5c4e');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (3, 'gce', '76nium52', 'zbuo4nrqrof');

-- Inserting into table: course_arrange --
INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483648);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483647);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 2, -2147483646);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483645);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 4, -2147483644);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 3, -2147483643);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 4, -2147483642);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 3, -2147483641);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 4, -2147483640);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 3, -2147483639);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 4, -2147483638);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 3, -2147483637);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483636);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483635);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483634);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483633);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483632);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483631);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483630);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483629);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483628);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483627);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483626);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483625);

INSERT INTO "course_arrange" ("course_id", "teacher_id", "grade") VALUES (-2147483648, 1, -2147483624);
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
('gce',)
('posiie5unw6k',)
('t2__bb98a2',)
*/