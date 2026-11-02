-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Cat', 'animal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS "count___" FROM (SELECT * FROM "has_allergy" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "allergy_type" WHERE ("allergytype" = 'food')) AS RHS WHERE (LHS.allergy = RHS.allergy))) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Has_allergy AS T1 JOIN Allergy_type AS T2 ON T1.allergy = T2.allergy WHERE T2.allergytype = 'food';

/*
Prediction Result:
(0,)
*/