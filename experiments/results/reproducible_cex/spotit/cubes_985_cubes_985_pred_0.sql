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
INSERT INTO RACE VALUES (0, -1, 0, 0, 0);
INSERT INTO RACE VALUES (-1, -1, 0, 0, 0);
INSERT INTO TRACK VALUES (-1, NULL, NULL, NULL, 0);
INSERT INTO TRACK VALUES (0, 0, 0, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, seating FROM (SELECT * FROM (SELECT * FROM track ORDER BY year_opened DESC, track.track_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('0', '0', 0.0)
*/

-- Prediction Query
SELECT name, LOCATION, seating FROM track ORDER BY year_opened DESC, track.track_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('0', '0', 0.0)
*/