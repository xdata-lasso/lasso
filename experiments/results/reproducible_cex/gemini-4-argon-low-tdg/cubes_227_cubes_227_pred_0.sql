-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Bravo', 'John', 2, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Alpha', 'Jane', 4, 'F', 100, 10, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Charlie', 'Bob', 20, 'M', 200, 20, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Delta', 'Alice', 22, 'F', 200, 20, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Echo', 'Tom', 19, 'M', 300, 30, 'SFO');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (101, 'cat', 3, 10.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (102, 'cat', 4, 12.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (103, 'cat', 2, 8.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (104, 'dog', 4, 25.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (105, 'cat', 5, 11.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (1, 101);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (2, 102);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (3, 103);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (4, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."pettype" AS "pettype", "LHS"."pet_age" AS "pet_age", "LHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "pets" AS "RHS" ON ("LHS"."petid" = "RHS"."petid")) AS "LHS" INNER JOIN (SELECT * FROM "pets" WHERE ("pettype" = 'cat' AND pet_age >= 3)) AS RHS ON (LHS.petid = RHS.petid AND LHS.pettype = RHS.pettype AND LHS.pet_age = RHS.pet_age AND LHS.weight = RHS.weight)) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Bravo',)
*/

-- Prediction Query
SELECT T1.lname FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pet_age = 3 AND T3.pettype = 'cat';

/*
Prediction Result:
('Bravo',)
*/