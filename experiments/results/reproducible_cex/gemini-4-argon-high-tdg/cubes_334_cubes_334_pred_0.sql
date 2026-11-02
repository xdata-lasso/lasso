-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (1, '2023-01-10', 'Database Systems');
INSERT INTO course (Course_ID, Staring_Date, Course) VALUES (2, '2023-02-15', 'Algorithms');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, 'Zoe', '32', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (2, 'Alice', '33', 'Seattle');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (3, 'Bob', '31', 'Austin');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (4, 'Charlie', '34', 'Denver');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (5, 'Mike', '32', 'Chicago');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (6, 'Diana', '33', 'Miami');
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (1, 1, 1);
INSERT INTO course_arrange (Course_ID, Teacher_ID, Grade) VALUES (2, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM teacher WHERE (age = 33 OR age = 32) ORDER BY name, teacher.teacher_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Diana',)
('Mike',)
('Zoe',)
*/

-- Prediction Query
SELECT Name FROM teacher WHERE Age = 32 OR Age = 33;

/*
Prediction Result:
('Zoe',)
('Alice',)
('Mike',)
('Diana',)
*/