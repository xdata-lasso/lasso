-- Schema DDL
CREATE TABLE "CINEMA" (
    "SEAT_ID" INT,
    "FREE" INT,
    PRIMARY KEY ("SEAT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CINEMA VALUES (0, 2);
INSERT INTO CINEMA VALUES (-1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT SEAT_ID FROM CINEMA WHERE FREE IS TRUE AND (SEAT_ID - 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE IS TRUE) OR SEAT_ID + 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE IS TRUE));

/*
Prediction Result:
(-1,)
(0,)
*/