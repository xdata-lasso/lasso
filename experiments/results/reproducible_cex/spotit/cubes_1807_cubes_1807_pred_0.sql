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
INSERT INTO WRESTLER VALUES (0, 0, 100, 99, 10, 11);
INSERT INTO WRESTLER VALUES (-1, 1, 100, 100, 12, 13);
INSERT INTO ELIMINATION VALUES (4, 0, 0, 0, 0, 0);
INSERT INTO ELIMINATION VALUES (5, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name_other AS name FROM (SELECT LHS.wrestler_id AS wrestler_id, LHS.name AS name, LHS.reign AS reign, LHS.days_held AS days_held, LHS.location AS LOCATION, LHS.event AS event, RHS.wrestler_id AS wrestler_id_other, RHS.name AS name_other, RHS.reign AS reign_other, RHS.location AS location_other, RHS.event AS event_other FROM wrestler AS LHS INNER JOIN wrestler AS RHS ON (LHS.reign = RHS.days_held)) ORDER BY name;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT Name FROM wrestler WHERE Days_held < 100;

/*
Prediction Result:
*/