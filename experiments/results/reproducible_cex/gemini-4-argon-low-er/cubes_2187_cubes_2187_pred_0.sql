-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('B', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('A', 'Environment');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergy, allergytype FROM allergy_type ORDER BY allergy;

/*
Gold Result:
('A', 'Environment')
('B', 'Food')
*/

-- Prediction Query
SELECT allergy, allergytype FROM Allergy_type;

/*
Prediction Result:
('B', 'Food')
('A', 'Environment')
*/