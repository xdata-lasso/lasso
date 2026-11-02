-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (StuID, LName, Major) VALUES (1, 'A', 1);
INSERT INTO Student (StuID, LName, Major) VALUES (2, 'B', 2);
INSERT INTO Student (StuID, LName, Major) VALUES (3, 'C', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT * FROM (SELECT * FROM (SELECT lname, major, MAX(n) AS n FROM (SELECT lname, major, COUNT(*) AS n FROM student GROUP BY lname, major) GROUP BY lname, major) ORDER BY lname) LIMIT 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major ORDER BY COUNT(*) DESC, major NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/