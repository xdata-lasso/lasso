-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (101, '2023-09-01', 'Database Systems');
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (102, '2023-09-02', 'Algorithms');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, 'Zack', '35', 'Chicago');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (2, 'Bob', '25', 'New York');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (3, 'Alice', '40', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (4, 'Bob', '40', 'Boston');
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (101, 1, 1);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (102, 1, 2);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (101, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM teacher ORDER BY name, teacher.teacher_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM teacher ORDER BY Age ASC, teacher.teacher_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Zack',)
('Alice',)
('Bob',)
*/