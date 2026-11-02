-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'rhs_7810bc', 'rhs_87e3f0', 1, 'rhs_e6202e', 1, 1, 'rhs_7861eb');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'rhs_10b64c', 'rhs_06c150', 1, 'rhs_9208ba', 1, 1, 'rhs_220574');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'rhs_7810bc', 'rhs_87e3f0', 1, 'rhs_e6202e', 1, 1, 'rhs_7861eb');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

-- Inserting into table: pets --
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1, 'A', 1, 1.0);

INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483647, 'A', 1, 1.0);

-- Inserting into table: has_pet --
INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (3, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "age" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "pets" WHERE ("pettype" = 'dog' OR "pettype" <> 'cat')) AS RHS ON (LHS.petid = RHS.petid)) ORDER BY fname, "fname" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('rhs_87e3f0', 1)
('stu_ebb0d7', -55602865)
('stu_ebb0d7', -55602865)
('stu_ebb0d7', -55602865)
('stu_ebb0d7', -55602865)
*/

-- Prediction Query
SELECT T1.fname, T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'dog' AND NOT T1.stuid IN (SELECT T1.stuid FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'cat');

/*
Prediction Result:
*/