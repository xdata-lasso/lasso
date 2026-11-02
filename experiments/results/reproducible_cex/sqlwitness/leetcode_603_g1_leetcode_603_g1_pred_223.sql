-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 0), (0, 1), (2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, COALESCE(LAG(SEAT_ID, 1) OVER (), -1) AS PREVSEAT, COALESCE(LEAD(SEAT_ID, 1) OVER (), -1) AS NEXTSEAT FROM CINEMA WHERE FREE = 1 ORDER BY SEAT_ID) AS T WHERE SEAT_ID = PREVSEAT + 1 OR SEAT_ID = NEXTSEAT - 1;

/*
Prediction Result:
(0,)
*/