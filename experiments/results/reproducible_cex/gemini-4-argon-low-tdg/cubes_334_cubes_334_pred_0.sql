-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, 'Charlie', '33', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (2, 'Alice', '32', 'Denver');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (3, 'Bob', '31', 'Austin');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (4, 'David', '34', 'Seattle');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (5, 'Eve', NULL, 'Miami');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM teacher WHERE (age = 33 OR age = 32) ORDER BY name, teacher.teacher_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM teacher WHERE Age = 32 OR Age = 33;

/*
Prediction Result:
('Charlie',)
('Alice',)
*/