-- Schema DDL
CREATE TABLE "AIRCRAFT" (
    "AIRCRAFT_ID" INT,
    "ORDER_YEAR" INT,
    "MANUFACTURER" TEXT,
    "MODEL" TEXT,
    "FLEET_SERIES" TEXT,
    "POWERTRAIN" TEXT,
    "FUEL_PROPULSION" TEXT,
    PRIMARY KEY ("AIRCRAFT_ID")
);
CREATE TABLE "PILOT" (
    "PILOT_ID" INT,
    "PILOT_NAME" TEXT,
    "RANK" INT,
    "AGE" INT,
    "NATIONALITY" TEXT,
    "POSITION" TEXT,
    "JOIN_YEAR" INT,
    "TEAM" TEXT,
    PRIMARY KEY ("PILOT_ID")
);
CREATE TABLE "PILOT_RECORD" (
    "PILOT_ID" INT,
    "AIRCRAFT_ID" INT,
    "DATE" TEXT,
    "RECORD_ID" INT,
    PRIMARY KEY ("PILOT_ID", "AIRCRAFT_ID", "DATE"),
    FOREIGN KEY ("AIRCRAFT_ID") REFERENCES "AIRCRAFT"("AIRCRAFT_ID"),
    FOREIGN KEY ("PILOT_ID") REFERENCES "PILOT"("PILOT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO AIRCRAFT VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO AIRCRAFT VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO PILOT VALUES (2, NULL, NULL, NULL, -1, 15, NULL, NULL);
INSERT INTO PILOT VALUES (3, NULL, 0, NULL, -2, 15, NULL, NULL);
INSERT INTO PILOT_RECORD VALUES (2, 0, 0, 0);
INSERT INTO PILOT_RECORD VALUES (2, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.pilot_id AS pilot_id, LHS.pilot_name AS pilot_name, LHS.rank AS rank, LHS.age AS age, LHS.nationality AS nationality, LHS.position AS POSITION, LHS.join_year AS join_year, LHS.team AS team FROM pilot AS LHS INNER JOIN (SELECT POSITION, MAX(n) AS n FROM (SELECT age, POSITION, COUNT(*) AS n FROM pilot GROUP BY age, POSITION) GROUP BY POSITION) AS RHS ON (LHS.pilot_id = RHS.n AND LHS.position = RHS.position)) ORDER BY nationality;

/*
Gold Result:
('-1',)
*/

-- Prediction Query
SELECT Nationality FROM pilot GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/