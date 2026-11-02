-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1008, 'ago', 1009, 1010.5);
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1011, 'site', 1012, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight AS max_weight_, pettype FROM (SELECT pettype, MAX(weight) AS weight FROM pets GROUP BY pettype) ORDER BY max_weight_, pettype NULLS LAST;

/*
Gold Result:
(None, 'site')
(1010.5, 'ago')
*/

-- Prediction Query
SELECT MAX(weight), petType FROM pets GROUP BY petType;

/*
Prediction Result:
(1010.5, 'ago')
(None, 'site')
*/