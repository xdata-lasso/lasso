-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'Zoe', 21, 'F', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Jones', 'Liam', 19, 'M', 600, 1122, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (103, 'Brown', 'Mia', 23, 'F', 520, 1123, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (104, 'Davis', 'Noah', 20, 'M', 540, 1124, 'BOS');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (201, 'dog', 4, 25.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (202, 'cat', 3, 9.2);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (203, 'bird', 2, 0.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (204, NULL, 1, 5.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (101, 201);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (102, 202);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (103, 203);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (104, 204);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "age" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "pets" WHERE ("pettype" = 'dog' OR "pettype" <> 'cat')) AS RHS ON (LHS.petid = RHS.petid)) ORDER BY fname, "fname" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
('Mia', 23)
('Zoe', 21)
*/

-- Prediction Query
SELECT T1.fname, T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'dog' AND NOT T1.stuid IN (SELECT T1.stuid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'cat');

/*
Prediction Result:
('Zoe', 21)
*/