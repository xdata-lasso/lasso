-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Lee', 'Chris', 19, 'M', 520, 1148, 'BOS');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (1, 'dog', 2, 1.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (2, 'dog', 4, 1.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (3, 'dog', 6, 5.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (4, 'bird', 3, 8.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (5, 'bird', 3, 11.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (6, 'cat', 5, 15.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (1, 1);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (2, 1);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (1, 2);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanweight AS avg_weight_, pettype FROM (SELECT pettype, AVG(weight) AS meanweight FROM pets GROUP BY pettype) ORDER BY avg_weight_, pettype NULLS LAST;

/*
Gold Result:
(2.5, 'dog')
(10.0, 'bird')
(15.0, 'cat')
*/

-- Prediction Query
SELECT AVG(weight), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(10.0, 'bird')
(15.0, 'cat')
(2.5, 'dog')
*/