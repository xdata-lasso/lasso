-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Doe', 'Jane', 22, 'F', 600, 1121, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (103, 'Lee', 'Chris', 19, 'M', 550, 1148, 'BOS');
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (1, 'zebra', 1, 50.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (2, 'zebra', 2, 60.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (3, 'cat', 1, 8.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (4, 'cat', 6, 11.2);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (5, 'turtle', 4, 2.1);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (6, 'turtle', 4, 2.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (7, 'dog', 2, 25.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (8, 'dog', 2, 28.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (9, 'dog', 8, 35.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (10, 'rabbit', 2, 3.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (11, 'rabbit', 6, 4.2);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (12, 'hamster', 3, 0.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (13, 'hamster', 3, 0.6);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (14, 'hamster', 6, 0.7);
INSERT INTO Has_Pet (StuID, PetID) VALUES (101, 3);
INSERT INTO Has_Pet (StuID, PetID) VALUES (102, 3);
INSERT INTO Has_Pet (StuID, PetID) VALUES (101, 7);
INSERT INTO Has_Pet (StuID, PetID) VALUES (102, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanpet_age AS avg_pet_age_, maxpet_age AS max_pet_age_, pettype FROM (SELECT LHS.pettype AS pettype, LHS.meanpet_age AS meanpet_age, RHS.maxpet_age AS maxpet_age FROM (SELECT pettype, AVG(pet_age) AS meanpet_age FROM pets GROUP BY pettype) AS LHS LEFT JOIN (SELECT pettype, MAX(pet_age) AS maxpet_age FROM pets GROUP BY pettype) AS RHS ON (LHS.pettype = RHS.pettype)) ORDER BY avg_pet_age_, max_pet_age_ NULLS LAST, pettype NULLS LAST;

/*
Gold Result:
(1.5, 2, 'zebra')
(3.5, 6, 'cat')
(4.0, 4, 'turtle')
(4.0, 6, 'hamster')
(4.0, 6, 'rabbit')
(4.0, 8, 'dog')
*/

-- Prediction Query
SELECT AVG(pet_age), MAX(pet_age), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(3.5, 6, 'cat')
(4.0, 8, 'dog')
(4.0, 6, 'hamster')
(4.0, 6, 'rabbit')
(4.0, 4, 'turtle')
(1.5, 2, 'zebra')
*/