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
INSERT INTO CAPTAIN VALUES (-1, 1, 9, 10, 0, 11);
INSERT INTO CAPTAIN VALUES (0, 1, 9, 10, 0, 11);
INSERT INTO SHIP VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CLASS FROM (SELECT CLASS, COUNT(*) AS n FROM captain GROUP BY CLASS) WHERE (n >= 2) ORDER BY CLASS;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT CLASS FROM captain GROUP BY CLASS HAVING COUNT(*) > 2;

/*
Prediction Result:
*/