-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Nuts', 'Food');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, NULL, 'Lisa', 20, 'F', 100, 200, 'NYC');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Nuts', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "allergy", "allergytype" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "LHS"."stuid" AS "stuid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "RHS"."stuid" AS "stuid" FROM "allergy_type" AS "LHS" INNER JOIN "has_allergy" AS "RHS" ON ("LHS"."allergy" = "RHS"."allergy")) AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" = 'Lisa')) AS RHS ON (LHS.stuid = RHS.stuid AND LHS.lname = RHS.lname AND LHS.fname = RHS.fname AND LHS.age = RHS.age AND LHS.sex = RHS.sex AND LHS.major = RHS.major AND LHS.advisor = RHS.advisor AND LHS.city_code = RHS.city_code)) ORDER BY allergy, "allergy" NULLS LAST, "allergytype" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Allergy, T1.AllergyType FROM Allergy_type AS T1 JOIN Has_allergy AS T2 ON T1.Allergy = T2.Allergy JOIN Student AS T3 ON T3.StuID = T2.StuID WHERE T3.Fname = 'Lisa' ORDER BY T1.Allergy, T2.allergy NULLS LAST, T2.stuid NULLS LAST, T3.stuid NULLS LAST;

/*
Prediction Result:
('Nuts', 'Food')
*/