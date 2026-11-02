-- Schema DDL
CREATE TABLE "RACE" (
    "RACE_ID" INT,
    "TRACK_ID" TEXT,
    "NAME" TEXT,
    "CLASS" TEXT,
    "DATE" TEXT,
    PRIMARY KEY ("RACE_ID"),
    FOREIGN KEY ("TRACK_ID") REFERENCES "TRACK"("TRACK_ID")
);
CREATE TABLE "TRACK" (
    "TRACK_ID" INT,
    "NAME" TEXT,
    "LOCATION" TEXT,
    "SEATING" FLOAT,
    "YEAR_OPENED" FLOAT,
    PRIMARY KEY ("TRACK_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO RACE VALUES (0, -1, 11, 0, 12);
INSERT INTO RACE VALUES (1, -1, 11, 0, 12);
INSERT INTO TRACK VALUES (-1, 0, 0, 0, 0);
INSERT INTO TRACK VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM (SELECT LHS.class AS CLASS, LHS.track_id AS track_id, LHS.n AS n, RHS.class AS class_other, RHS.track_id AS track_id_other, RHS.n AS n_other FROM (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS LHS CROSS JOIN (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS RHS) WHERE (n > n_other) ORDER BY CLASS;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/