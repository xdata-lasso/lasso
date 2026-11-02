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
INSERT INTO STUDENT VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO STUDENT VALUES (-1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO HAS_PET VALUES (0, -1);
INSERT INTO HAS_PET VALUES (-1, -1);
INSERT INTO PETS VALUES (0, NULL, NULL, NULL);
INSERT INTO PETS VALUES (-1, 0, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pettype, weight FROM (SELECT * FROM (SELECT * FROM pets ORDER BY pet_age, pets.petid NULLS LAST) LIMIT 1);

/*
Gold Result:
('0', 0.0)
*/

-- Prediction Query
SELECT pettype, weight FROM pets ORDER BY pet_age, pets.petid NULLS LAST LIMIT 1;

/*
Prediction Result:
('0', 0.0)
*/