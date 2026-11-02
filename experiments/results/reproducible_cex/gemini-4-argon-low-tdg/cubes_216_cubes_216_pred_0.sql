-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests tie-breaking in ORDER BY: identical max_weight_ values across different PetTypes, including a NULL PetType.
-- Specifically tests the "pettype NULLS LAST" secondary sorting requirement and GROUP BY on NULL PetType.
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (1, 'Zebra', 4, 15.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (2, 'Antelope', 3, 15.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (3, NULL, 2, 15.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (4, NULL, 5, 5.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (5, 'Bear', 6, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight AS max_weight_, pettype FROM (SELECT pettype, MAX(weight) AS weight FROM pets GROUP BY pettype) ORDER BY max_weight_, pettype NULLS LAST;

/*
Gold Result:
(5.0, 'Bear')
(15.0, 'Antelope')
(15.0, 'Zebra')
(15.0, None)
*/

-- Prediction Query
SELECT MAX(weight), petType FROM pets GROUP BY petType;

/*
Prediction Result:
(15.0, None)
(15.0, 'Antelope')
(5.0, 'Bear')
(15.0, 'Zebra')
*/