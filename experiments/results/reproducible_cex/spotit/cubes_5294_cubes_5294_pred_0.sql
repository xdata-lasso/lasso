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
INSERT INTO ENTREPRENEUR VALUES (0, 0, -1, 44, 45);
INSERT INTO ENTREPRENEUR VALUES (1, 0, 0, 49, 50);
INSERT INTO PEOPLE VALUES (-1, 46, 1, 47, 48);
INSERT INTO PEOPLE VALUES (0, 51, 1, 52, 53);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, LHS.name AS name, LHS.height AS height, LHS.weight AS weight, LHS.date_of_birth AS date_of_birth FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM entrepreneur AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) AS LHS INNER JOIN (SELECT MAX(height) AS height FROM people) AS RHS ON (LHS.height = RHS.height)) ORDER BY company;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT T1.Company FROM entrepreneur AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC, T1.entrepreneur_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/