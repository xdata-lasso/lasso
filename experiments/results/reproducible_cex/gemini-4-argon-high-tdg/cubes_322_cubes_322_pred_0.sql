-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (101, '2023-09-01', 'Database Systems');
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (102, '2023-09-02', 'Algorithms');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, 'Alice', '45', 'Chicago');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (2, 'Bob', '25', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (3, 'Middle', '30', 'Zebra City');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (4, 'Zulu', '30', 'Apple Town');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (5, 'Alpha', '30', 'Mango Village');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (6, 'Charlie', '50', 'Seattle');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (7, 'David', '50', 'Seattle');
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (101, 1, 1);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (102, 1, 2);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (101, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age, hometown FROM teacher ORDER BY age, teacher.teacher_id NULLS LAST;

/*
Gold Result:
('25', 'Boston')
('30', 'Zebra City')
('30', 'Apple Town')
('30', 'Mango Village')
('45', 'Chicago')
('50', 'Seattle')
('50', 'Seattle')
*/

-- Prediction Query
SELECT Age, Hometown FROM teacher;

/*
Prediction Result:
('45', 'Chicago')
('25', 'Boston')
('30', 'Zebra City')
('30', 'Apple Town')
('30', 'Mango Village')
('50', 'Seattle')
('50', 'Seattle')
*/