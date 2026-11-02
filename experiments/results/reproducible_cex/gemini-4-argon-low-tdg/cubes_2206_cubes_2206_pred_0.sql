-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests zero matching rows for the inner subquery (allergytype = 'food').
-- Gold query returns an empty result set (0 rows), whereas a standard aggregate COUNT(*) without OVER() would return 1 row with value 0.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 1, 10, 'NYC');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Pollen', 'environmental');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Cat', 'animal');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Pollen', 101);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Cat', 101);
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