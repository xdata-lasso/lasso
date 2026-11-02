-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (reverse insertion order), sorting on Allergy vs AllergyType, and INNER JOIN vs NO JOIN mutants (some allergies have no matching rows in Has_Allergy).
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Dust', 'Environmental');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Bees', 'Animal');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Smith', 'John', 20, 'M', 600, 1121, 'NYC');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergy, allergytype FROM allergy_type ORDER BY allergy;

/*
Gold Result:
('Bees', 'Animal')
('Dust', 'Environmental')
('Peanuts', 'Food')
*/

-- Prediction Query
SELECT allergy, allergytype FROM Allergy_type;

/*
Prediction Result:
('Peanuts', 'Food')
('Dust', 'Environmental')
('Bees', 'Animal')
*/