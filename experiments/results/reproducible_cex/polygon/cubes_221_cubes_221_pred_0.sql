-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (11, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (10, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Has_Pet" ("stuid", "petid") VALUES (NULL, 12);
INSERT INTO "Has_Pet" ("stuid", "petid") VALUES (10, 12);
INSERT INTO "Pets" ("petid", "pettype", "pet_age", "weight") VALUES (12, '15', NULL, NULL);
INSERT INTO "Pets" ("petid", "pettype", "pet_age", "weight") VALUES (13, NULL, -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanpet_age AS avg_pet_age_, maxpet_age AS max_pet_age_, pettype FROM (SELECT LHS.pettype AS pettype, LHS.meanpet_age AS meanpet_age, RHS.maxpet_age AS maxpet_age FROM (SELECT pettype, AVG(pet_age) AS meanpet_age FROM pets GROUP BY pettype) AS LHS LEFT JOIN (SELECT pettype, MAX(pet_age) AS maxpet_age FROM pets GROUP BY pettype) AS RHS ON (LHS.pettype = RHS.pettype)) ORDER BY avg_pet_age_, max_pet_age_ NULLS LAST, pettype NULLS LAST;

/*
Gold Result:
(None, None, '15')
(-1.0, None, None)
*/

-- Prediction Query
SELECT AVG(pet_age), MAX(pet_age), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(-1.0, -1, None)
(None, None, '15')
*/