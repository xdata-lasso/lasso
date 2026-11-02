-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests gaps in seat_id (non-consecutive IDs should not be considered adjacent even if they are consecutive rows via LEAD/LAG) and insertion out of order (tests missing ORDER BY).
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 1);
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
WITH TMP AS (SELECT *, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXT_SEAT, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS PREV_SEAT FROM CINEMA) SELECT DISTINCT SEAT_ID FROM TMP WHERE FREE = TRUE AND PREV_SEAT = TRUE OR FREE = TRUE AND NEXT_SEAT = TRUE ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(5,)
(10,)
*/