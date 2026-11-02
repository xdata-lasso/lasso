-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Pollen', 'environmental');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Adams', 'Alice', 18, 'F', 100, 1001, 'ATL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Baker', 'Bob', 20, 'M', 600, 1002, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Clark', 'Charlie', 22, 'M', 50, 1003, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Davis', 'Diana', 24, 'F', 600, 1004, 'DEN');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 2);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Pollen', 2);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT major FROM student ORDER BY major;

/*
Gold Result:
(50,)
(100,)
(600,)
*/

-- Prediction Query
SELECT DISTINCT Major FROM Student;

/*
Prediction Result:
(100,)
(600,)
(50,)
*/