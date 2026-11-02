-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1161, 'specific', 1161, 1162.5);
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1160, 'about', 1168, 1169.5);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1163, 'Smith', 'Danielle', 1164, 'brother', 1165, 1166, 'Ryanmouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1170, 'Smith', 'Stephanie', 1171, 'type', 1172, 1173, 'Teresaburgh');
INSERT INTO "has_pet" ("stuid", "petid") VALUES (1163, 1161);
INSERT INTO "has_pet" ("stuid", "petid") VALUES (1170, 1160);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "petid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) WHERE ("lname" = 'Smith') ORDER BY petid, "petid" NULLS LAST;

/*
Gold Result:
(1160,)
(1161,)
*/

-- Prediction Query
SELECT T2.petid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid WHERE T1.Lname = 'Smith';

/*
Prediction Result:
(1161,)
(1160,)
*/