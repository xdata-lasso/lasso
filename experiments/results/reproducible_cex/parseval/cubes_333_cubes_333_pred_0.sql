-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: teacher --
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483648, 'tea_90d9eb', '5k5swwqcgs', '9n8');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483647, 'tea_c73ffb', '4', 'gu7v');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483646, 'tea_90d9eb', 'e4', 'hria2ypuzhs');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483645, 'tea_8ed94e', 'rwbbp6luhvd', 'tti');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483644, 'tea_c73ffb', 'bnp', 'mdpos');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483643, 'tea_fb58dd', 'ie5', 'nw6klf');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483642, NULL, 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (-2147483641, 'tea_c73ffb', 'zbuo4nrqrof', 'qyp5s5bbp0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name FROM teacher INTERSECT SELECT name FROM teacher) ORDER BY name;

/*
Gold Result:
(None,)
('tea_8ed94e',)
('tea_90d9eb',)
('tea_c73ffb',)
('tea_fb58dd',)
*/

-- Prediction Query
SELECT name FROM teacher WHERE hometown <> 'little lever urban district';

/*
Prediction Result:
('tea_90d9eb',)
('tea_c73ffb',)
('tea_90d9eb',)
('tea_8ed94e',)
('tea_c73ffb',)
('tea_fb58dd',)
(None,)
('tea_c73ffb',)
*/