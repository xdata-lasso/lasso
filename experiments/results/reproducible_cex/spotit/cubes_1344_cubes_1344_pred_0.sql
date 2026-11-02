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
INSERT INTO PERSON VALUES (3, 1, 11, 7, 0);
INSERT INTO PERSON VALUES (4, -1, 5, 6, 0);
INSERT INTO PERSONFRIEND VALUES (4, 4, -2147483648);
INSERT INTO PERSONFRIEND VALUES (4, 4, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, job FROM (SELECT gender, job, AVG(age) AS meanage FROM person GROUP BY gender, job) ORDER BY avg_age_, job NULLS LAST;

/*
Gold Result:
(-1.0, '0')
(1.0, '0')
*/

-- Prediction Query
SELECT AVG(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(0.0, '0')
*/