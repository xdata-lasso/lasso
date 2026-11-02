-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('animal', 'food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Dust', NULL);
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Pollen', 'Animal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS "count___" FROM "allergy_type" WHERE ("allergytype" = 'animal') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Allergy_type WHERE allergytype = 'animal';

/*
Prediction Result:
(0,)
*/