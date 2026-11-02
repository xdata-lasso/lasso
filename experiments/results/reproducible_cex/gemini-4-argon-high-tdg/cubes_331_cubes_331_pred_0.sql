-- Schema DDL
CREATE TABLE "course" ("Course_ID" INTEGER PRIMARY KEY, "Staring_Date" TEXT, "Course" TEXT);

CREATE TABLE "teacher" ("Teacher_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" TEXT, "Hometown" TEXT);

CREATE TABLE "course_arrange" ("Course_ID" INTEGER, "Teacher_ID" INTEGER, "Grade" INTEGER, PRIMARY KEY ("Course_ID", "Teacher_ID", "Grade"), FOREIGN KEY ("Teacher_ID") REFERENCES "teacher" ("Teacher_ID"), FOREIGN KEY ("Course_ID") REFERENCES "course" ("Course_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (1, 'Zack', '20', 'Chicago');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (2, 'Bob', '40', 'Austin');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (10, 'Dan', '50', 'Austin');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (3, 'Alice', '30', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (11, 'Eve', '35', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (12, 'Frank', '45', 'Boston');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (5, 'Grace', '28', 'Miami');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (30, 'Hank', '31', 'Seattle');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (31, 'Ivy', '32', 'Seattle');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (32, 'Jack', '33', 'Seattle');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (33, 'Kate', '34', 'Seattle');
INSERT INTO teacher (Teacher_ID, Name, Age, Hometown) VALUES (34, 'Liam', '36', 'Seattle');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hometown FROM (SELECT LHS.hometown AS hometown, LHS.n AS n, RHS.name AS name, RHS.age AS age FROM (SELECT hometown, COUNT(*) AS n FROM teacher GROUP BY hometown) AS LHS INNER JOIN teacher AS RHS ON (LHS.n = RHS.teacher_id AND LHS.hometown = RHS.hometown)) ORDER BY hometown;

/*
Gold Result:
('Austin',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT Hometown FROM teacher GROUP BY Hometown ORDER BY COUNT(*) DESC, Hometown NULLS LAST LIMIT 1;

/*
Prediction Result:
('Seattle',)
*/