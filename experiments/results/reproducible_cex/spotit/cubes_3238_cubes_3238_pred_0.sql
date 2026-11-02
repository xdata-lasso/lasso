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
INSERT INTO MISSION VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO MISSION VALUES (1, 0, 0, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (-1, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (0, -1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM ship AS LHS WHERE NOT EXISTS(SELECT 1 FROM mission AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Name FROM ship WHERE NOT Ship_ID IN (SELECT Ship_ID FROM mission);

/*
Prediction Result:
('0',)
*/