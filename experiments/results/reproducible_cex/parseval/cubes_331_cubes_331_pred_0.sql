-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: teacher --
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1, '5k5swwqcgs', '9n8', 'tea_767fa9');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483647, '4', 'gu7v', 'tea_767fa9');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (2, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (3, 'tti', 'bnp', 'mdpos');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (4, 'ie5', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (5, 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (6, '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (7, 'klex14ji', '7zwau2dwyr', '13pyu');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (8, '8d99rljsl', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (9, 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (10, 'v', 'ph2', 'nd');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (11, 'wnqcx', '5hncprjtu0d', '79fjgq8');
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
('tea_767fa9',)
*/