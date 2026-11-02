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
INSERT INTO MISSION VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO MISSION VALUES (0, -1, 0, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (-1, 0, NULL, 0, 3999);
INSERT INTO SHIP VALUES (0, 0, 0, 0, 6001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM ship WHERE (tonnage > 6000 OR tonnage = 4000) ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE Tonnage > 6000 INTERSECT SELECT TYPE FROM ship WHERE Tonnage < 4000;

/*
Prediction Result:
*/