-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Milk', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Eggs', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Nuts', 'Food');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Bob', 20, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Ray', 'Tom', 20, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Lee', 'Sam', 18, 'M', 200, 20, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Kim', 'Dan', 22, 'M', 300, 30, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Ann', 'Mary', 19, 'F', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, 'May', 'Jane', 19, 'F', 100, 10, 'NYC');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Milk', 1);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Eggs', 4);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Nuts', 5);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Milk', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."allergy" AS "allergy", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."n" AS "n", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."allergy" AS "allergy", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."n" AS "n" FROM "has_allergy" AS "LHS" CROSS JOIN (SELECT "age", "sex", COUNT(*) AS "n" FROM "student" GROUP BY "age", "sex") AS "RHS") AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("sex" <> 'F')) AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."age" = "RHS"."age" AND "LHS"."sex" = "RHS"."sex")) WHERE ("allergy" = 'Milk' OR "allergy" = 'Eggs') ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM has_allergy AS T1 JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T2.sex = 'F' AND T1.allergy = 'Milk' OR T1.allergy = 'Eggs';

/*
Prediction Result:
(2,)
*/