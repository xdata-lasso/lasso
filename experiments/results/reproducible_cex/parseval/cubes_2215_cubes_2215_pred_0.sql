-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: allergy_type --
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('lhs_24a914', 'lhs_63066b');

INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('lhs_623c48', 'lhs_532f6d');

INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('A', 'lhs_63066b');

INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('C', 'all_a171da');

INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('Q', 'lhs_63066b');

INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('G', 'lhs_63066b');

INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('_', 'lhs_63066b');

INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('rhs_a39158', 'lhs_63066b');

-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'rhs_4147f4', 'rhs_5a65ed', 1, 'rhs_2648a6', 1, 1, 'rhs_e585c8');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'rhs_174f89', 'rhs_f6a20f', 1, 'rhs_870b4e', 1, 1, 'rhs_2ff356');

-- Inserting into table: has_allergy --
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('C', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('A', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('A', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('A', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('A', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('rhs_a39158', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);

INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('lhs_24a914', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT "allergytype", "sex", COUNT(DISTINCT "stuid") AS "n_distinct" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "LHS"."stuid" AS "stuid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."allergy" AS "allergy", "LHS"."allergytype" AS "allergytype", "RHS"."stuid" AS "stuid" FROM "allergy_type" AS "LHS" INNER JOIN "has_allergy" AS "RHS" ON ("LHS"."allergy" = "RHS"."allergy")) AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) GROUP BY "allergytype", "sex") WHERE ("sex" = 'M' AND "allergytype" = 'food') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Student WHERE sex = 'M' AND StuID IN (SELECT StuID FROM Has_allergy AS T1 JOIN Allergy_Type AS T2 ON T1.Allergy = T2.Allergy WHERE T2.allergytype = 'food');

/*
Prediction Result:
(0,)
*/