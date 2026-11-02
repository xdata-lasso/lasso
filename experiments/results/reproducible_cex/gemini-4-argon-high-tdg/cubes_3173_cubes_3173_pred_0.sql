-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 300, 500, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Doe', 'Jane', 21, 'F', 200, 500, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Brown', 'Bob', 22, 'M', 200, NULL, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'White', 'Alice', 19, 'F', 100, 600, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Green', 'Charlie', 20, 'M', 100, 601, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Black', 'Eve', 23, 'F', 100, 602, 'SFO');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Gray', 'Frank', 20, 'M', NULL, 700, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (8, 'Blue', 'Grace', 21, 'F', NULL, 701, 'DEN');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major, n AS count___ FROM (SELECT major, COUNT(*) AS n FROM student GROUP BY major) WHERE (n >= 2 AND n < 30) ORDER BY major, count___ NULLS LAST;

/*
Gold Result:
(None, 2)
(100, 3)
(200, 2)
*/

-- Prediction Query
SELECT Major, COUNT(*) FROM Student GROUP BY Major HAVING COUNT(Major) BETWEEN 2 AND 30;

/*
Prediction Result:
(100, 3)
(200, 2)
*/