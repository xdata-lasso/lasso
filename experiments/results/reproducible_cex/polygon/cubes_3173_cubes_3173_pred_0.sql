-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (10, '16', '16', 16, '16', NULL, 16, '16');
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (9, '16', '16', 16, '16', NULL, 16, '16');
INSERT INTO "Restaurant" ("resid", "resname", "address", "rating") VALUES (12, '16', '16', 16);
INSERT INTO "Restaurant" ("resid", "resname", "address", "rating") VALUES (11, '16', '16', 16);
INSERT INTO "Type_Of_Restaurant" ("restypeid", "resid") VALUES (14, 11);
INSERT INTO "Restaurant_Type" ("restypeid", "restypename", "restypedescription") VALUES (13, '16', '16');
INSERT INTO "Restaurant_Type" ("restypeid", "restypename", "restypedescription") VALUES (14, '16', '16');
INSERT INTO "Visits_Restaurant" ("resid", "stuid", "time", "spent") VALUES (NULL, NULL, 16, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major, n AS count___ FROM (SELECT major, COUNT(*) AS n FROM student GROUP BY major) WHERE (n >= 2 AND n < 30) ORDER BY major, count___ NULLS LAST;

/*
Gold Result:
(None, 2)
*/

-- Prediction Query
SELECT Major, COUNT(*) FROM Student GROUP BY Major HAVING COUNT(Major) BETWEEN 2 AND 30;

/*
Prediction Result:
*/