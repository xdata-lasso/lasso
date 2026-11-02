-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Anna', 21, 'F', 200, 10, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Jones', 'Bob', 19, 'M', 600, 20, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Cara', 23, 'F', 100, 30, 'CHI');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (10, 'cat', 3, 8.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (20, 'dog', 5, 22.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (2, 10);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (1, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "major", "age" FROM (SELECT * FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."stuid" AS "stuid_other", "RHS"."petid" AS "petid", "RHS"."lname" AS "lname_other", "RHS"."fname" AS "fname_other", "RHS"."age" AS "age_other", "RHS"."sex" AS "sex_other", "RHS"."major" AS "major_other", "RHS"."advisor" AS "advisor_other", "RHS"."city_code" AS "city_code_other", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM "student" AS "LHS" CROSS JOIN (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "pets" AS "RHS" ON ("LHS"."petid" = "RHS"."petid")) AS "RHS") WHERE ("stuid" <> "stuid_other")) WHERE ("pettype" = 'cat') ORDER BY major, "major" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
(100, 23)
(200, 21)
*/

-- Prediction Query
SELECT major, age FROM student WHERE NOT stuid IN (SELECT T1.stuid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'cat');

/*
Prediction Result:
(200, 21)
(100, 23)
*/