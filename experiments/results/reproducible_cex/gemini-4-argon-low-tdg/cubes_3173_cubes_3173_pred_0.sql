-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests lower boundaries (n = 1, 2, 3), ordering (negative, positive, NULL majors), and column confusion (Advisor = Major vs Advisor != Major, NULLs in other columns).
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 200, 100, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, NULL, NULL, NULL, NULL, 200, NULL, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Brown', 'Bob', 22, 'M', -50, 200, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Davis', 'Eve', 22, 'F', -50, 300, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Miller', 'Tom', 23, 'M', -50, 400, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, 'Wilson', 'Sam', 19, 'M', NULL, 200, 'MIA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (8, 'Moore', 'Ann', 20, 'F', NULL, 200, 'DAL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major, n AS count___ FROM (SELECT major, COUNT(*) AS n FROM student GROUP BY major) WHERE (n >= 2 AND n < 30) ORDER BY major, count___ NULLS LAST;

/*
Gold Result:
(None, 2)
(-50, 3)
(200, 2)
*/

-- Prediction Query
SELECT Major, COUNT(*) FROM Student GROUP BY Major HAVING COUNT(Major) BETWEEN 2 AND 30;

/*
Prediction Result:
(-50, 3)
(200, 2)
*/