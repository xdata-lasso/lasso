-- Schema DDL
CREATE TABLE "PERPETRATOR" (
    "PERPETRATOR_ID" INT,
    "PEOPLE_ID" INT,
    "DATE" TEXT,
    "YEAR" FLOAT,
    "LOCATION" TEXT,
    "COUNTRY" TEXT,
    "KILLED" INT,
    "INJURED" INT,
    PRIMARY KEY ("PERPETRATOR_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    "HOME_TOWN" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PERPETRATOR VALUES (-1, 1, 13, 14, 9, 15, 1, 0);
INSERT INTO PERPETRATOR VALUES (0, 0, 16, 17, 1, 18, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other FROM perpetrator AS LHS INNER JOIN perpetrator AS RHS ON (LHS.people_id = RHS.perpetrator_id AND LHS.location = RHS.location)) ORDER BY LOCATION;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('9',)
*/