-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'environmental');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 200, 'NYC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT "allergytype", "sex", COUNT(DISTINCT "stuid") AS "n_distinct" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "LHS"."stuid" AS "stuid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "RHS"."stuid" AS "stuid" FROM "allergy_type" AS "LHS" INNER JOIN "has_allergy" AS "RHS" ON ("LHS"."allergy" = "RHS"."allergy")) AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) GROUP BY "allergytype", "sex") WHERE ("sex" = 'M' AND "allergytype" = 'food') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Student WHERE sex = 'M' AND StuID IN (SELECT StuID FROM Has_allergy AS T1 JOIN Allergy_Type AS T2 ON T1.Allergy = T2.Allergy WHERE T2.allergytype = 'food');

/*
Prediction Result:
(0,)
*/