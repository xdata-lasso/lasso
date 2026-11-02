-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('purpose', 'face');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('brother', 'election');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('ago', 'dog');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('site', 'chair');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergytype FROM (SELECT * FROM (SELECT * FROM (SELECT allergy, allergytype, COUNT(*) OVER () AS n FROM allergy_type) ORDER BY allergy) LIMIT 1);

/*
Gold Result:
('dog',)
*/

-- Prediction Query
SELECT allergytype FROM Allergy_type GROUP BY allergytype ORDER BY COUNT(*) DESC, allergytype NULLS LAST LIMIT 1;

/*
Prediction Result:
('chair',)
*/