-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('F' vs 'M', 'f', NULL), DISTINCT vs ALL (duplicate output rows with different StuIDs), ORDER BY fname ASC, and secondary ORDER BY stuid ASC.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Smith', 'Alice', 20, 'F', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Smith', 'Alice', 20, 'F', 101, 2, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Jones', 'Beth', 22, 'F', 100, 1, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Brown', 'Charlie', 21, 'M', 102, 3, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Davis', 'Diana', 19, 'f', 103, 4, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Miller', 'Eve', 23, NULL, 104, 5, 'SEA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname", "age" FROM "student" WHERE ("sex" = 'F') ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Alice', 'Smith', 20)
('Alice', 'Smith', 20)
('Beth', 'Jones', 22)
*/

-- Prediction Query
SELECT Fname, Lname, Age FROM Student WHERE Sex = 'F';

/*
Prediction Result:
('Alice', 'Smith', 20)
('Beth', 'Jones', 22)
('Alice', 'Smith', 20)
*/