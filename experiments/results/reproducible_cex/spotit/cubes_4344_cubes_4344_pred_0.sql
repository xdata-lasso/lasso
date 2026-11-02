-- Schema DDL
CREATE TABLE "WRESTLER" (
    "WRESTLER_ID" INT,
    "NAME" TEXT,
    "REIGN" TEXT,
    "DAYS_HELD" TEXT,
    "LOCATION" TEXT,
    "EVENT" TEXT,
    PRIMARY KEY ("WRESTLER_ID")
);
CREATE TABLE "ELIMINATION" (
    "ELIMINATION_ID" TEXT,
    "WRESTLER_ID" TEXT,
    "TEAM" TEXT,
    "ELIMINATED_BY" TEXT,
    "ELIMINATION_MOVE" TEXT,
    "TIME" TEXT,
    PRIMARY KEY ("ELIMINATION_ID"),
    FOREIGN KEY ("WRESTLER_ID") REFERENCES "WRESTLER"("WRESTLER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO WRESTLER VALUES (-1, 10, 11, 0, 12, 13);
INSERT INTO WRESTLER VALUES (0, 1, 1, 1, 8, 9);
INSERT INTO ELIMINATION VALUES (5, -1, 0, 0, 0, 0);
INSERT INTO ELIMINATION VALUES (6, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.days_held AS days_held, RHS.wrestler_id AS wrestler_id, RHS.days_held AS days_held_other, RHS.location AS LOCATION, RHS.event AS event FROM (SELECT name, MIN(days_held) AS days_held FROM wrestler GROUP BY name) AS LHS INNER JOIN wrestler AS RHS ON (LHS.name = RHS.name AND LHS.days_held = RHS.reign)) ORDER BY name;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held ASC, wrestler.wrestler_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('10',)
*/