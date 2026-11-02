-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1067, 'dog', 1069, 1071.5);
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1068, 'cat', 1076.0, 1080.5);
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1077, 'dog', 1079, 1081.5);
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1078, 'cat', 1086.0, 1090.5);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1073, 'Clark', 'Joseph', 1074, 'write', 1075, 1076, 'New Cynthiaside');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1083, 'Daniel', 'Frank', 1084, 'hundred', 1085, 1086, 'Veronicaside');
INSERT INTO "has_pet" ("stuid", "petid") VALUES (1073, 1067);
INSERT INTO "has_pet" ("stuid", "petid") VALUES (1083, 1077);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "pets" AS "RHS" ON ("LHS"."petid" = "RHS"."petid")) WHERE ("pettype" = 'dog' OR "pettype" = 'cat') ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
('Frank',)
('Joseph',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fname FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'cat' OR T3.pettype = 'dog';

/*
Prediction Result:
('Joseph',)
('Frank',)
*/