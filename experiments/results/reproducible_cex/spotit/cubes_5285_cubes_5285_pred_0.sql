-- Schema DDL
CREATE TABLE "ENTREPRENEUR" (
    "ENTREPRENEUR_ID" INT,
    "PEOPLE_ID" INT,
    "COMPANY" TEXT,
    "MONEY_REQUESTED" FLOAT,
    "INVESTOR" TEXT,
    PRIMARY KEY ("ENTREPRENEUR_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    "DATE_OF_BIRTH" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ENTREPRENEUR VALUES (-1, -1, 0, 0, 0);
INSERT INTO ENTREPRENEUR VALUES (0, -1, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 21, -1, 1, 22);
INSERT INTO PEOPLE VALUES (-1, 23, -1, 0, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight FROM (SELECT LHS.height AS height, RHS.people_id AS people_id, RHS.name AS name, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM (SELECT MIN(height) AS height FROM people) AS LHS LEFT JOIN people AS RHS ON (LHS.height = RHS.height)) ORDER BY weight;

/*
Gold Result:
(0.0,)
(1.0,)
*/

-- Prediction Query
SELECT Weight FROM people ORDER BY Height ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0,)
*/