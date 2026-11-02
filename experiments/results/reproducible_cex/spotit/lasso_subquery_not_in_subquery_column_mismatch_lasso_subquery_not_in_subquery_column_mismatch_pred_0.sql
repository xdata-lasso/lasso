-- Schema DDL
CREATE TABLE "RACES" (
    "RACE_ID" INT,
    "YEAR" INT,
    "NAME" TEXT,
    PRIMARY KEY ("RACE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO RACES VALUES (0, 2000, NULL);
INSERT INTO RACES VALUES (1, 2017, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Races WHERE year = 2017 AND NOT name IN (SELECT name FROM Races WHERE year = 2000);

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM Races WHERE year = 2017 AND NOT race_id IN (SELECT race_id FROM Races WHERE year = 2000);

/*
Prediction Result:
('0',)
*/