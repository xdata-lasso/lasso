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
WITH LEAD_LAG_SEAT AS (SELECT SEAT_ID, FREE, LEAD(FREE, 1, 0) OVER (ORDER BY SEAT_ID) AS LEAD_SEAT, LAG(FREE, 1, 0) OVER (ORDER BY SEAT_ID) AS LAG_SEAT FROM CINEMA) SELECT SEAT_ID FROM LEAD_LAG_SEAT WHERE (FREE = 1 AND LEAD_SEAT = 1) OR (FREE = 1 AND LAG_SEAT = 1) ORDER BY 1, SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
(5,)
(10,)
*/