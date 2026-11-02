-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1017, 'site', 1018, 1019.5);
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1020, 'face', 1021, NULL);
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1023, 'face', 1024, 1025.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanweight AS avg_weight_, pettype FROM (SELECT pettype, AVG(weight) AS meanweight FROM pets GROUP BY pettype) ORDER BY avg_weight_, pettype NULLS LAST;

/*
Gold Result:
(1019.5, 'site')
(1025.5, 'face')
*/

-- Prediction Query
SELECT AVG(weight), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(1025.5, 'face')
(1019.5, 'site')
*/