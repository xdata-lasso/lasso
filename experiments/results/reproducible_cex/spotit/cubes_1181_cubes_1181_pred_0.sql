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
INSERT INTO CAPTAIN VALUES (-1, 0, 9, 0, 0, 0);
INSERT INTO CAPTAIN VALUES (0, 0, 8, NULL, 0, 0);
INSERT INTO SHIP VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM captain ORDER BY ship_id DESC, captain.captain_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('9',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age, captain.captain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('8',)
*/