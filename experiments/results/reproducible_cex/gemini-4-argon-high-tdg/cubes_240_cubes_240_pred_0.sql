-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Smith', 'Alice', 22, 'F', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (103, 'Jones', 'Smith', 19, 'M', 550, 1148, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (104, 'Smith', 'Bob', 21, 'M', 520, 1121, 'CHI');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (10, 'dog', 3, 25.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (20, 'cat', 2, 8.2);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (30, 'dog', 5, 40.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (40, 'parrot', 1, 1.1);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (50, 'cat', 4, 10.4);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (101, 50);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (102, 30);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (101, 20);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (103, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "petid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) WHERE ("lname" = 'Smith') ORDER BY petid, "petid" NULLS LAST;

/*
Gold Result:
(20,)
(30,)
(50,)
*/

-- Prediction Query
SELECT T2.petid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid WHERE T1.Lname = 'Smith';

/*
Prediction Result:
(50,)
(30,)
(20,)
*/