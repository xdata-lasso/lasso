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
INSERT INTO RACE VALUES (-1, 0, 0, 0, 0);
INSERT INTO RACE VALUES (0, 0, 0, 0, 0);
INSERT INTO TRACK VALUES (0, 0, 0, 0, 2000);
INSERT INTO TRACK VALUES (1, NULL, 0, NULL, 2001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, seating FROM track WHERE (year_opened >= 2000.0) ORDER BY name, track.track_id NULLS LAST;

/*
Gold Result:
(None, None)
('0', 0.0)
*/

-- Prediction Query
SELECT name, seating FROM track WHERE year_opened > 2000 ORDER BY seating, track.track_id NULLS LAST;

/*
Prediction Result:
(None, None)
*/