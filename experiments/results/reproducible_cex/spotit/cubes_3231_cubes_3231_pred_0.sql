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
INSERT INTO MISSION VALUES (-1, 1, 0, 0, 0, 0, 0);
INSERT INTO MISSION VALUES (0, 1, 0, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (0, -1, 0, 6, 0);
INSERT INTO SHIP VALUES (1, 0, 0, 7, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SHIP WHERE (NATIONALITY <> 'United States' OR NATIONALITY <> 'United Kingdom') ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE Nationality = 'United States' OR Nationality = 'United Kingdom';

/*
Prediction Result:
*/