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
INSERT INTO PERSON VALUES (9, 40, 10, 0, 7);
INSERT INTO PERSON VALUES (4, 0, 5, 0, 7);
INSERT INTO PERSONFRIEND VALUES (4, 4, 0);
INSERT INTO PERSONFRIEND VALUES (4, 9, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, gender FROM (SELECT gender, job, COUNT(*) AS n FROM person GROUP BY gender, job) WHERE (n < 40) ORDER BY count___, gender NULLS LAST;

/*
Gold Result:
(2, '0')
*/

-- Prediction Query
SELECT COUNT(*), gender FROM Person WHERE age < 40 GROUP BY gender;

/*
Prediction Result:
(1, '0')
*/