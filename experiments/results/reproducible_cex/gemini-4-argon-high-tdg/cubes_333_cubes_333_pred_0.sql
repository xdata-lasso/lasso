-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (1, '2023-09-01', 'Mathematics');
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (2, '2023-09-02', 'Physics');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, 'Zack', '45', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (2, 'Alice', '30', 'Chicago');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (3, 'Bob', '25', 'Austin');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (4, 'Alice', '50', 'Denver');
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (1, 1, 1);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (2, 1, 2);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (1, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name FROM teacher INTERSECT SELECT name FROM teacher) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM teacher WHERE hometown <> 'little lever urban district';

/*
Prediction Result:
('Zack',)
('Alice',)
('Bob',)
('Alice',)
*/