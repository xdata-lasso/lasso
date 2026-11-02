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
INSERT INTO MISSION VALUES (-1, -1, 0, 0, 0, 0, 0);
INSERT INTO MISSION VALUES (0, -1, 0, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (-1, 9, 0, 0, NULL);
INSERT INTO SHIP VALUES (0, 8, 0, 0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM ship ORDER BY tonnage DESC, ship.ship_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('8',)
*/

-- Prediction Query
SELECT Name FROM ship ORDER BY Tonnage DESC, ship.ship_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('8',)
*/