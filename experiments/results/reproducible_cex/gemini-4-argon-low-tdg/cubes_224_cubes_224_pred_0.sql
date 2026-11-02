-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests PetType variations ('dog', 'cat', 'bird', 'Cat', NULL) and INNER JOIN filtering vs OUTER JOINs
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 101, 201, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 22, 'F', 102, 202, 'LA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Charlie', 19, 'M', 101, 201, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'White', 'Emily', 21, 'F', 103, 203, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Green', 'David', 23, 'M', 104, 204, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Black', 'NoPet', 25, 'F', 105, 205, 'MIA');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (10, 'dog', 5, 20.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (20, 'cat', 3, 8.2);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (30, 'bird', 1, 0.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (40, NULL, 2, 5.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (50, 'Cat', 4, 9.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (60, 'dog', 7, 30.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (1, 10);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (2, 20);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (3, 30);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (4, 40);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (5, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "age" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "pets" WHERE ("pettype" = 'dog' OR "pettype" <> 'cat')) AS RHS ON (LHS.petid = RHS.petid)) ORDER BY fname, "fname" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
('Charlie', 19)
('David', 23)
('John', 20)
*/

-- Prediction Query
SELECT T1.fname, T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'dog' AND NOT T1.stuid IN (SELECT T1.stuid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'cat');

/*
Prediction Result:
('John', 20)
*/