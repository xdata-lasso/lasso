-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('face', 'chair');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('dog', 'election');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergy, allergytype FROM allergy_type ORDER BY allergy;

/*
Gold Result:
('dog', 'election')
('face', 'chair')
*/

-- Prediction Query
SELECT allergy, allergytype FROM Allergy_type;

/*
Prediction Result:
('face', 'chair')
('dog', 'election')
*/