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
INSERT INTO STUDENT VALUES (-1, 16, 17, 21, 18, 0, 0, 19);
INSERT INTO STUDENT VALUES (0, 22, 23, 21, 24, 0, 0, 25);
INSERT INTO HAS_PET VALUES (-1, 1);
INSERT INTO HAS_PET VALUES (0, 1);
INSERT INTO PETS VALUES (1, 0, 0, 0);
INSERT INTO PETS VALUES (0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT stuid FROM student WHERE (age = 20) INTERSECT SELECT stuid FROM has_pet)) ORDER BY count___;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid WHERE T1.age > 20;

/*
Prediction Result:
(2,)
*/