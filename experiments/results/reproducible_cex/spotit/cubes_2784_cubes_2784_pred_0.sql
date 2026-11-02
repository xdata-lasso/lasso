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
INSERT INTO ENTREPRENEUR VALUES (-1, 1, 9, 10, 0);
INSERT INTO ENTREPRENEUR VALUES (0, 0, 7, 8, NULL);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor FROM (SELECT LHS.entrepreneur_id AS entrepreneur_id, LHS.people_id AS people_id, LHS.company AS company, LHS.money_requested AS money_requested, LHS.investor AS investor, RHS.people_id AS people_id_other FROM entrepreneur AS LHS INNER JOIN (SELECT people_id, COUNT(*) AS n FROM entrepreneur GROUP BY people_id) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY investor;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/