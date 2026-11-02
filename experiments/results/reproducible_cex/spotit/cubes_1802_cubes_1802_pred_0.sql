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
INSERT INTO WRESTLER VALUES (-1, 8, -1, 0, 18, 19);
INSERT INTO WRESTLER VALUES (0, 8, 0, 0, 9, 10);
INSERT INTO ELIMINATION VALUES (6, 0, 0, 0, 0, 0);
INSERT INTO ELIMINATION VALUES (7, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT days_held AS reign FROM (SELECT days_held, event, COUNT(*) AS n FROM (SELECT wrestler_id, name, days_held AS reign, days_held, LOCATION, event, wrestler_id_other, days_held_other, location_other, event_other FROM (SELECT LHS.wrestler_id AS wrestler_id, LHS.name AS name, LHS.reign AS reign, LHS.days_held AS days_held, LHS.location AS LOCATION, LHS.event AS event, RHS.wrestler_id AS wrestler_id_other, RHS.days_held AS days_held_other, RHS.location AS location_other, RHS.event AS event_other FROM wrestler AS LHS INNER JOIN wrestler AS RHS ON (LHS.name = RHS.name AND LHS.days_held = RHS.reign))) GROUP BY days_held, event) ORDER BY reign;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT Reign FROM wrestler GROUP BY Reign ORDER BY COUNT(*) DESC, Reign NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/