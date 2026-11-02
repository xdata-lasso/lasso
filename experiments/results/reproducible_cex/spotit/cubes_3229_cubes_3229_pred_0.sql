-- Schema DDL
CREATE TABLE "MISSION" (
    "MISSION_ID" INT,
    "SHIP_ID" INT,
    "CODE" TEXT,
    "LAUNCHED_YEAR" INT,
    "LOCATION" TEXT,
    "SPEED_KNOTS" INT,
    "FATE" TEXT,
    PRIMARY KEY ("MISSION_ID"),
    FOREIGN KEY ("SHIP_ID") REFERENCES "SHIP"("SHIP_ID")
);
CREATE TABLE "SHIP" (
    "SHIP_ID" INT,
    "NAME" TEXT,
    "TYPE" TEXT,
    "NATIONALITY" TEXT,
    "TONNAGE" INT,
    PRIMARY KEY ("SHIP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MISSION VALUES (0, 2, 0, 0, 0, 0, 0);
INSERT INTO MISSION VALUES (-1, 3, 0, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (2, 10, 9, 0, 0);
INSERT INTO SHIP VALUES (3, 8, 9, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.nationality AS nationality, LHS.type AS TYPE, LHS.n AS n, RHS.name AS name, RHS.type AS type_other, RHS.tonnage AS tonnage FROM (SELECT nationality, TYPE, COUNT(*) AS n FROM ship GROUP BY nationality, TYPE) AS LHS INNER JOIN ship AS RHS ON (LHS.n = RHS.ship_id AND LHS.nationality = RHS.nationality)) ORDER BY nationality;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Nationality FROM ship GROUP BY Nationality HAVING COUNT(*) > 2;

/*
Prediction Result:
*/