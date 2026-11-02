-- Schema DDL
CREATE TABLE "STUDENT" (
    "STUID" INT,
    "LNAME" TEXT,
    "FNAME" TEXT,
    "AGE" INT,
    "SEX" TEXT,
    "MAJOR" INT,
    "ADVISOR" INT,
    "CITY_CODE" TEXT,
    PRIMARY KEY ("STUID")
);
CREATE TABLE "HAS_PET" (
    "STUID" INT,
    "PETID" INT,
    FOREIGN KEY ("STUID") REFERENCES "STUDENT"("STUID"),
    FOREIGN KEY ("PETID") REFERENCES "PETS"("PETID")
);
CREATE TABLE "PETS" (
    "PETID" INT,
    "PETTYPE" TEXT,
    "PET_AGE" INT,
    "WEIGHT" FLOAT,
    PRIMARY KEY ("PETID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STUDENT VALUES (-2147483647, 0, 0, -2147483648, 0, -2147483648, -2147483648, 0);
INSERT INTO STUDENT VALUES (-2147483648, 0, 0, -2147483648, 0, -2147483648, -2147483648, 0);
INSERT INTO HAS_PET VALUES (-2147483648, -2147483647);
INSERT INTO HAS_PET VALUES (-2147483648, -2147483648);
INSERT INTO PETS VALUES (-2147483648, NULL, -3, 51);
INSERT INTO PETS VALUES (-2147483647, NULL, -1, 51);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanpet_age AS avg_pet_age_, maxpet_age AS max_pet_age_, pettype FROM (SELECT LHS.pettype AS pettype, LHS.meanpet_age AS meanpet_age, RHS.maxpet_age AS maxpet_age FROM (SELECT pettype, AVG(pet_age) AS meanpet_age FROM pets GROUP BY pettype) AS LHS LEFT JOIN (SELECT pettype, MAX(pet_age) AS maxpet_age FROM pets GROUP BY pettype) AS RHS ON (LHS.pettype = RHS.pettype)) ORDER BY avg_pet_age_, max_pet_age_ NULLS LAST, pettype NULLS LAST;

/*
Gold Result:
(-2.0, None, None)
*/

-- Prediction Query
SELECT AVG(pet_age), MAX(pet_age), pettype FROM pets GROUP BY pettype;

/*
Prediction Result:
(-2.0, -1, None)
*/