-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (1, 'Dog', 2, 15.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (2, 'Cat', 3, 15.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (3, NULL, 1, 15.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (4, 'Rabbit', 4, NULL);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (5, 'Hamster', 2, 10.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (6, 'Hamster', 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanweight AS avg_weight_, pettype FROM (SELECT pettype, AVG(weight) AS meanweight FROM pets GROUP BY pettype) ORDER BY avg_weight_, pettype NULLS LAST;

/*
Gold Result:
(None, 'Rabbit')
(10.0, 'Hamster')
(15.0, 'Cat')
(15.0, 'Dog')
(15.0, None)
*/

-- Prediction Query
SELECT AVG(weight), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(15.0, None)
(15.0, 'Cat')
(15.0, 'Dog')
(10.0, 'Hamster')
(None, 'Rabbit')
*/