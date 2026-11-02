-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Charlie', 20, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Jones', 'Alice', 21, 'F', 200, 20, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Williams', 'Bob', 19, 'M', 100, 10, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Taylor', 'David', 22, 'M', 300, 30, 'BOS');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (10, 'dog', 3, 25.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (20, 'cat', 2, 8.2);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (30, 'parrot', 5, 1.1);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (40, 'dog', 4, 30.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (1, 10);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (2, 20);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (3, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "pets" AS "RHS" ON ("LHS"."petid" = "RHS"."petid")) WHERE ("pettype" = 'dog' OR "pettype" = 'cat') ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fname FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'cat' OR T3.pettype = 'dog';

/*
Prediction Result:
('Charlie',)
('Alice',)
*/