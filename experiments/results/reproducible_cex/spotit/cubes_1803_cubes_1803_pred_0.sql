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
INSERT INTO WRESTLER VALUES (0, 8, 0, 0, 0, 0);
INSERT INTO WRESTLER VALUES (1, 7, 0, NULL, 0, 0);
INSERT INTO ELIMINATION VALUES (4, 1, 0, 0, 0, 0);
INSERT INTO ELIMINATION VALUES (5, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM wrestler ORDER BY name, wrestler.wrestler_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('7',)
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held ASC, wrestler.wrestler_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('7',)
*/