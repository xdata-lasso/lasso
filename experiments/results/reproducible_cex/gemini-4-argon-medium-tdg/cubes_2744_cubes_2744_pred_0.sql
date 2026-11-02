-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Smith', 'John', 'Prof', 'M', 1111, '101', 'A');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Doe', 'Jane', 'Assoc', 'F', 2222, '102', 'B');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Adams', 'Bob', 20, 'M', 10, 300, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Baker', 'Sue', 21, 'F', 10, 300, 'LA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Clark', 'Dan', 22, 'M', 20, 200, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Evans', 'Eve', 20, 'F', 30, 100, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Frank', 'Fred', 21, 'M', 30, 100, 'MIA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Green', 'Grace', 22, 'F', 30, 100, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Smith', 'John', 20, 'M', 40, 400, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (8, 'Hill', 'Hank', 21, 'M', 40, 400, 'DAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (9, 'Smith', 'Alice', 19, 'F', 50, 500, 'HOU');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Brown', 'John', 20, 'M', 50, 500, 'PHX');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT advisor AS facid FROM (SELECT advisor, COUNT(*) AS n FROM (SELECT * FROM student AS LHS WHERE NOT EXISTS(SELECT 1 FROM faculty AS RHS WHERE (LHS.fname = RHS.fname AND LHS.lname = RHS.lname))) GROUP BY advisor) WHERE (n >= 2) ORDER BY facid;

/*
Gold Result:
(100,)
(300,)
(500,)
*/

-- Prediction Query
SELECT T1.FacID FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID = T2.advisor GROUP BY T1.FacID HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/