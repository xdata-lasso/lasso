-- Schema DDL
CREATE TABLE "PERSON" (
    "NAME" TEXT,
    "AGE" INT,
    "CITY" TEXT,
    "GENDER" TEXT,
    "JOB" TEXT,
    PRIMARY KEY ("NAME")
);
CREATE TABLE "PERSONFRIEND" (
    "FRIEND" TEXT,
    "NAME" TEXT,
    "YEAR" INT,
    FOREIGN KEY ("FRIEND") REFERENCES "PERSON"("NAME"),
    FOREIGN KEY ("NAME") REFERENCES "PERSON"("NAME")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PERSON VALUES (3, -1, 8, 9, 0);
INSERT INTO PERSON VALUES (4, -2, 8, 9, 0);
INSERT INTO PERSONFRIEND VALUES (4, 4, 0);
INSERT INTO PERSONFRIEND VALUES (4, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age AS min_age_, job FROM (SELECT job, MIN(age) AS age FROM person GROUP BY job) ORDER BY min_age_, job NULLS LAST;

/*
Gold Result:
(-2, '0')
*/

-- Prediction Query
SELECT MIN(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(-2, '0')
*/