-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out-of-order insertion), duplicate AllergyType values, and unreferenced allergies vs multiple-referenced allergies (kills INNER JOIN / LEFT JOIN mutants and ORDER BY column/direction mutants).
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Dust', 'Environmental');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Bee Stings', 'Animal');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Shellfish', 'Food');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1002, 'Doe', 'Jane', 19, 'F', 600, 1121, 'NYC');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 1001);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 1002);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Dust', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergy, allergytype FROM allergy_type ORDER BY allergy;

/*
Gold Result:
('Bee Stings', 'Animal')
('Dust', 'Environmental')
('Peanuts', 'Food')
('Shellfish', 'Food')
*/

-- Prediction Query
SELECT allergy, allergytype FROM Allergy_type;

/*
Prediction Result:
('Peanuts', 'Food')
('Dust', 'Environmental')
('Bee Stings', 'Animal')
('Shellfish', 'Food')
*/