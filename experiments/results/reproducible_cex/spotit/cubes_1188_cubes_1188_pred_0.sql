-- Schema DDL
CREATE TABLE "CAPTAIN" (
    "CAPTAIN_ID" INT,
    "SHIP_ID" INT,
    "NAME" TEXT,
    "AGE" TEXT,
    "CLASS" TEXT,
    "RANK" TEXT,
    PRIMARY KEY ("CAPTAIN_ID"),
    FOREIGN KEY ("SHIP_ID") REFERENCES "SHIP"("SHIP_ID")
);
CREATE TABLE "SHIP" (
    "SHIP_ID" INT,
    "NAME" TEXT,
    "TYPE" TEXT,
    "BUILT_YEAR" FLOAT,
    "CLASS" TEXT,
    "FLAG" TEXT,
    PRIMARY KEY ("SHIP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CAPTAIN VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO CAPTAIN VALUES (0, 1, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (1, NULL, NULL, NULL, 0, NULL);
INSERT INTO SHIP VALUES (0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, TYPE, flag FROM (SELECT * FROM (SELECT * FROM ship ORDER BY built_year DESC, ship.ship_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('0', '0', '0')
*/

-- Prediction Query
SELECT name, TYPE, flag FROM ship ORDER BY built_year DESC, ship.ship_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('0', '0', '0')
*/