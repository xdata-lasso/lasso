-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (1, NULL, 4, 5.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (2, NULL, 6, 7.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (3, 'dog', 5, 10.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (4, 'cat', NULL, 4.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (5, 'bird', 2, 1.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (6, 'bird', NULL, 1.2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanpet_age AS avg_pet_age_, maxpet_age AS max_pet_age_, pettype FROM (SELECT LHS.pettype AS pettype, LHS.meanpet_age AS meanpet_age, RHS.maxpet_age AS maxpet_age FROM (SELECT pettype, AVG(pet_age) AS meanpet_age FROM pets GROUP BY pettype) AS LHS LEFT JOIN (SELECT pettype, MAX(pet_age) AS maxpet_age FROM pets GROUP BY pettype) AS RHS ON (LHS.pettype = RHS.pettype)) ORDER BY avg_pet_age_, max_pet_age_ NULLS LAST, pettype NULLS LAST;

/*
Gold Result:
(None, None, 'cat')
(2.0, 2, 'bird')
(5.0, 5, 'dog')
(5.0, None, None)
*/

-- Prediction Query
SELECT AVG(pet_age), MAX(pet_age), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(5.0, 6, None)
(2.0, 2, 'bird')
(None, None, 'cat')
(5.0, 5, 'dog')
*/