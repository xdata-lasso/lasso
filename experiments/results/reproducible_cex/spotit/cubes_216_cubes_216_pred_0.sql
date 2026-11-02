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
INSERT INTO STUDENT VALUES (1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO HAS_PET VALUES (0, 0);
INSERT INTO HAS_PET VALUES (0, 0);
INSERT INTO PETS VALUES (0, 0, 0, 0);
INSERT INTO PETS VALUES (-1, 0, 0, 841);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight AS max_weight_, pettype FROM (SELECT pettype, MAX(weight) AS weight FROM pets GROUP BY pettype) ORDER BY max_weight_, pettype NULLS LAST;

/*
Gold Result:
(841.0, '0')
*/

-- Prediction Query
SELECT MAX(weight), petType FROM pets GROUP BY petType;

/*
Prediction Result:
(841.0, '0')
*/