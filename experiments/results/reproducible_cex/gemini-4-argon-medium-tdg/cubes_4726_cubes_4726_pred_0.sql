-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Pollen', 'Environmental');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Eggs', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Soy', NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Taylor', 'Lisa', 19, 'F', 101, 2001, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (11, 'Adams', 'Lisa', NULL, 'F', 102, 2002, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (12, 'White', 'Lisa', 20, 'F', 103, 2003, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (13, NULL, 'Lisa', 21, 'F', 104, 2004, 'DEN');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Pollen', 10);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Soy', 10);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Eggs', 11);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Eggs', 12);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Pollen', 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "allergy", "allergytype" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "LHS"."stuid" AS "stuid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "RHS"."stuid" AS "stuid" FROM "allergy_type" AS "LHS" INNER JOIN "has_allergy" AS "RHS" ON ("LHS"."allergy" = "RHS"."allergy")) AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" = 'Lisa')) AS RHS ON (LHS.stuid = RHS.stuid AND LHS.lname = RHS.lname AND LHS.fname = RHS.fname AND LHS.age = RHS.age AND LHS.sex = RHS.sex AND LHS.major = RHS.major AND LHS.advisor = RHS.advisor AND LHS.city_code = RHS.city_code)) ORDER BY allergy, "allergy" NULLS LAST, "allergytype" NULLS LAST;

/*
Gold Result:
('Pollen', 'Environmental')
('Soy', None)
*/

-- Prediction Query
SELECT T1.Allergy, T1.AllergyType FROM Allergy_type AS T1 JOIN Has_allergy AS T2 ON T1.Allergy = T2.Allergy JOIN Student AS T3 ON T3.StuID = T2.StuID WHERE T3.Fname = 'Lisa' ORDER BY T1.Allergy, T2.allergy NULLS LAST, T2.stuid NULLS LAST, T3.stuid NULLS LAST;

/*
Prediction Result:
('Eggs', 'Food')
('Eggs', 'Food')
('Pollen', 'Environmental')
('Pollen', 'Environmental')
('Soy', None)
*/