-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set (0 matching rows for ('dog', 'F')) vs COUNT(*) without GROUP BY (which returns 0 instead of empty set).
-- Also tests INNER JOIN vs LEFT/RIGHT OUTER JOIN by including unlinked students and pets.
-- Reference Query Output: Empty Set
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Alice', 20, 'F', 101, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Brown', 'Charlie', 22, 'M', 101, 1001, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Davis', 'Diana', 19, 'F', 103, 1003, 'BOS');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (10, 'dog', 3, 25.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (20, 'cat', 2, 10.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (30, 'dog', 4, 30.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (1, 20);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "pettype", "sex", COUNT(*) AS "n" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "pets" AS "RHS" ON ("LHS"."petid" = "RHS"."petid")) GROUP BY "pettype", "sex") WHERE ("pettype" = 'dog' AND "sex" = 'F') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T2.petid = T3.petid WHERE T1.sex = 'F' AND T3.pettype = 'dog';

/*
Prediction Result:
(0,)
*/