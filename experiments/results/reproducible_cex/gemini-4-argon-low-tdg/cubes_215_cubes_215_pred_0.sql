-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests tie-breaking in ORDER BY: multiple PetTypes (including NULL) having the exact same average weight.
-- Specifically tests "pettype NULLS LAST" and ASC vs DESC on the secondary sort column.
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (1, 'zebra', 4, 15.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (2, 'antelope', 2, 10.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (3, 'antelope', 6, 20.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (4, NULL, 3, 15.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (5, 'bear', 5, 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanweight AS avg_weight_, pettype FROM (SELECT pettype, AVG(weight) AS meanweight FROM pets GROUP BY pettype) ORDER BY avg_weight_, pettype NULLS LAST;

/*
Gold Result:
(15.0, 'antelope')
(15.0, 'zebra')
(15.0, None)
(30.0, 'bear')
*/

-- Prediction Query
SELECT AVG(weight), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(15.0, None)
(15.0, 'antelope')
(30.0, 'bear')
(15.0, 'zebra')
*/