-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1, -55602865, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1, -59984348, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'stu_5554fd', 'stu_ebb0d7', 1, 'f', 1, -664303813, 'db6');

-- Inserting into table: pets --
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483648, 'pet_c4475b', -1022641847, 97.952323);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (3, 'pet_c4475b', 247012447, 868.436572);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (2, 'pet_c4475b', 1610062532, 475.173408);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1, 'pet_c4475b', 1744686505, 483.665643);

-- Inserting into table: has_pet --
INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, -2147483648);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 2);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, -2147483648);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 2);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 3);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 2);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 3);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, -2147483648);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 2);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 3);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "major", "age" FROM (SELECT * FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."stuid" AS "stuid_other", "RHS"."petid" AS "petid", "RHS"."lname" AS "lname_other", "RHS"."fname" AS "fname_other", "RHS"."age" AS "age_other", "RHS"."sex" AS "sex_other", "RHS"."major" AS "major_other", "RHS"."advisor" AS "advisor_other", "RHS"."city_code" AS "city_code_other", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM "student" AS "LHS" CROSS JOIN (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "pets" AS "RHS" ON ("LHS"."petid" = "RHS"."petid")) AS "RHS") WHERE ("stuid" <> "stuid_other")) WHERE ("pettype" = 'cat') ORDER BY major, "major" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT major, age FROM student WHERE NOT stuid IN (SELECT T1.stuid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'cat');

/*
Prediction Result:
(1, 1)
(1, 1)
(1, 1)
*/