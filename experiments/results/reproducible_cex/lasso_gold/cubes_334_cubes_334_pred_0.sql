-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1013, 'Amy Underwood', '33', 'Jasonfort');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1014, 'Jennifer Jones', '32', 'Wilkersonmouth');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1015, 'Charles Mcgee', '33', 'Coxberg');
INSERT INTO "teacher" ("teacher_id", "name", "age", "hometown") VALUES (1016, 'Nicole Patterson', '32', 'Daviston');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM teacher WHERE (age = 33 OR age = 32) ORDER BY name, teacher.teacher_id NULLS LAST;

/*
Gold Result:
('Amy Underwood',)
('Charles Mcgee',)
('Jennifer Jones',)
('Nicole Patterson',)
*/

-- Prediction Query
SELECT Name FROM teacher WHERE Age = 32 OR Age = 33;

/*
Prediction Result:
('Amy Underwood',)
('Jennifer Jones',)
('Charles Mcgee',)
('Nicole Patterson',)
*/