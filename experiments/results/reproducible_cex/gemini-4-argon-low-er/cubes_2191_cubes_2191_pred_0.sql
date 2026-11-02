-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Soy', 'Food');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 101, 1, 'NYC');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Soy', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "major" FROM (SELECT * FROM "student" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "has_allergy" WHERE ("allergy" = 'Soy')) AS RHS WHERE (LHS.stuid = RHS.stuid))) ORDER BY fname, "fname" NULLS LAST, "major" NULLS LAST;

/*
Gold Result:
('John', 101)
*/

-- Prediction Query
SELECT fname, major FROM Student WHERE NOT StuID IN (SELECT StuID FROM Has_allergy WHERE Allergy = 'Soy');

/*
Prediction Result:
*/