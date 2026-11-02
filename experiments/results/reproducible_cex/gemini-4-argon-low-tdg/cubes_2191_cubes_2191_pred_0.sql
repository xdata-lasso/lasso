-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in NOT EXISTS vs NOT IN:
-- If a row in Has_Allergy has Allergy = 'Soy' and StuID IS NULL,
-- NOT EXISTS will ignore it for existing students, whereas NOT IN (SELECT StuID FROM Has_Allergy WHERE Allergy = 'Soy') will evaluate to UNKNOWN and return 0 rows.
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Soy', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Dust', 'Environmental');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'White', 'Eve', 20, 'F', 201, 2001, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Black', 'Frank', 22, 'M', 202, 2002, 'MIA');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Soy', NULL);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES (NULL, 10);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Dust', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "major" FROM (SELECT * FROM "student" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "has_allergy" WHERE ("allergy" = 'Soy')) AS RHS WHERE (LHS.stuid = RHS.stuid))) ORDER BY fname, "fname" NULLS LAST, "major" NULLS LAST;

/*
Gold Result:
('Eve', 201)
('Frank', 202)
*/

-- Prediction Query
SELECT fname, major FROM Student WHERE NOT StuID IN (SELECT StuID FROM Has_allergy WHERE Allergy = 'Soy');

/*
Prediction Result:
*/