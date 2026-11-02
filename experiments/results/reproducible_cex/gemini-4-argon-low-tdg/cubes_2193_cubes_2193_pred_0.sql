-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate AllergyType values: 'Food' and 'Environmental')
-- 2. Missing ORDER BY or DESC ordering (inserted in reverse alphabetical order)
-- 3. Wrong column projection (Allergy != AllergyType)
-- 4. Unnecessary INNER JOIN with Has_Allergy ('Animal' has no matching rows in Has_Allergy)
-- 5. Unnecessary JOIN without DISTINCT ('Peanut' is linked to multiple students)
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Ragweed', 'Environmental');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Pollen', 'Environmental');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanut', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Milk', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Cat', 'Animal');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1002, 'Doe', 'Jane', 19, 'F', 600, 1121, 'NYC');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanut', 1001);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanut', 1002);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Ragweed', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT allergytype FROM allergy_type ORDER BY allergytype;

/*
Gold Result:
('Animal',)
('Environmental',)
('Food',)
*/

-- Prediction Query
SELECT DISTINCT allergytype FROM Allergy_type;

/*
Prediction Result:
('Environmental',)
('Food',)
('Animal',)
*/