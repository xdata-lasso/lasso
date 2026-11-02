-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering where insertion order, Allergy alphabetical order, and AllergyType alphabetical order all differ.
-- Also tests joins with Has_Allergy where the minimum Allergy is NOT in Has_Allergy, and another Allergy has the maximum count in Has_Allergy.
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Apples', 'Z_Fruit');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Bees', 'Animal');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 101, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 102, 1002, 'LAX');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 1);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 2);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Bees', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergytype FROM (SELECT * FROM (SELECT * FROM (SELECT allergy, allergytype, COUNT(*) OVER () AS n FROM allergy_type) ORDER BY allergy) LIMIT 1);

/*
Gold Result:
('Z_Fruit',)
*/

-- Prediction Query
SELECT allergytype FROM Allergy_type GROUP BY allergytype ORDER BY COUNT(*) DESC, allergytype NULLS LAST LIMIT 1;

/*
Prediction Result:
('Animal',)
*/