-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 100, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Doe', 'Jane', 22, 'F', 200, 20, 'LAX');
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (1, 'dog', 8, 5.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (2, 'dog', 3, 15.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (3, 'dog', 5, 10.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (4, 'cat', 9, 12.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (5, 'cat', 2, 25.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (6, 'cat', 6, 8.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (7, 'bird', 10, 2.5);
INSERT INTO Has_Pet (StuID, PetID) VALUES (1, 1);
INSERT INTO Has_Pet (StuID, PetID) VALUES (1, 4);
INSERT INTO Has_Pet (StuID, PetID) VALUES (2, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight AS max_weight_, pettype FROM (SELECT pettype, MAX(weight) AS weight FROM pets GROUP BY pettype) ORDER BY max_weight_, pettype NULLS LAST;

/*
Gold Result:
(2.5, 'bird')
(15.5, 'dog')
(25.0, 'cat')
*/

-- Prediction Query
SELECT MAX(weight), petType FROM pets GROUP BY petType;

/*
Prediction Result:
(2.5, 'bird')
(25.0, 'cat')
(15.5, 'dog')
*/