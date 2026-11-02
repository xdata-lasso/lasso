-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic threshold boundaries (n = 1, 2, 3), ORDER BY, and exact (Fname, LName) exclusion vs partial name matches.
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (10, 'Smith', 'John', 'Prof', 'M', 1111, '101', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (20, 'Doe', 'Jane', 'Assoc', 'F', 2222, '102', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (30, 'Brown', 'Charlie', 'Asst', 'M', 3333, '103', 'Sci');
-- Advisor 30: 2 valid students (n = 2, boundary included)
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Adams', 'Amy', 20, 'F', 100, 30, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Baker', 'Bob', 21, 'M', 100, 30, 'LAX');
-- Advisor 10: 3 valid students (n = 3, >2 included), testing partial name matches with Faculty ('Smith', 'John')
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Smith', 'Alice', 22, 'F', 200, 10, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Jones', 'John', 19, 'M', 200, 10, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'John', 'Smith', 20, 'M', 200, 10, 'SEA');
-- Advisor 20: 2 students total, but 1 matches Faculty ('Doe', 'Jane') -> n = 1 (boundary excluded)
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Doe', 'Jane', 23, 'F', 300, 20, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Clark', 'Kent', 21, 'M', 300, 20, 'MET');
-- Advisor 40: 1 valid student -> n = 1 (excluded)
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (8, 'Davis', 'Dan', 20, 'M', 100, 40, 'MIA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT advisor AS facid FROM (SELECT advisor, COUNT(*) AS n FROM (SELECT * FROM student AS LHS WHERE NOT EXISTS(SELECT 1 FROM faculty AS RHS WHERE (LHS.fname = RHS.fname AND LHS.lname = RHS.lname))) GROUP BY advisor) WHERE (n >= 2) ORDER BY facid;

/*
Gold Result:
(10,)
(30,)
*/

-- Prediction Query
SELECT T1.FacID FROM Faculty AS T1 JOIN Student AS T2 ON T1.FacID = T2.advisor GROUP BY T1.FacID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(10,)
(20,)
(30,)
*/