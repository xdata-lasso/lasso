-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Clark', 'ann', 20, 'F', 303, 10, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Adams', 'Bob', 21, 'M', 101, 20, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Adams', 'Cara', 22, 'F', 101, 20, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Baker', 'Dan', 19, 'M', 202, 30, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Baker', 'Eve', 20, 'F', 202, 30, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Baker', 'Frank', 21, 'M', 202, 30, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Evans', 'Grace', 22, 'F', 303, 10, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (8, 'Ford', 'Hank', 23, 'M', 303, 10, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (9, 'Green', 'Ivy', 20, 'F', 303, 10, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Hill', 'Jack', 21, 'M', 303, 10, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (11, 'Davis', 'Kim', 19, 'F', 401, 40, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (12, 'Davis', 'Leo', 20, 'M', 402, 40, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (13, 'Davis', 'Mia', 21, 'F', 403, 40, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (14, 'Davis', 'Ned', 22, 'M', 404, 40, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (15, 'Irwin', 'Ola', 18, 'F', 50, 50, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (16, 'Zane', 'Paul', 24, 'M', 505, 60, 'MIA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT * FROM (SELECT * FROM (SELECT lname, major, MAX(n) AS n FROM (SELECT lname, major, COUNT(*) AS n FROM student GROUP BY lname, major) GROUP BY lname, major) ORDER BY lname) LIMIT 1);

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT Major FROM STUDENT GROUP BY major ORDER BY COUNT(*) DESC, Major NULLS LAST LIMIT 1;

/*
Prediction Result:
(303,)
*/