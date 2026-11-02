-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (101, '2023-09-01', 'Mathematics');
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (102, '2023-09-02', 'Physics');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, 'Zoe', '45', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (2, 'Alice', '30', 'Austin');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (3, 'Bob', '35', 'Chicago');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (4, 'Charlie', '50', 'Denver');
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (101, 2, 1);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (101, 4, 2);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (102, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM teacher AS LHS WHERE NOT EXISTS(SELECT 1 FROM course_arrange AS RHS WHERE (LHS.teacher_id = RHS.teacher_id))) ORDER BY name;

/*
Gold Result:
('Bob',)
('Zoe',)
*/

-- Prediction Query
SELECT Name FROM teacher WHERE NOT Teacher_id IN (SELECT Teacher_id FROM course_arrange);

/*
Prediction Result:
('Zoe',)
('Bob',)
*/