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
INSERT INTO PERSON VALUES (3, 0, NULL, 0, 0);
INSERT INTO PERSON VALUES (4, 0, NULL, 0, 0);
INSERT INTO PERSONFRIEND VALUES (3, 3, 0);
INSERT INTO PERSONFRIEND VALUES (3, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_city_ FROM (SELECT COUNT(*) AS n FROM person) ORDER BY count_distinct_city_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM Person;

/*
Prediction Result:
(0,)
*/