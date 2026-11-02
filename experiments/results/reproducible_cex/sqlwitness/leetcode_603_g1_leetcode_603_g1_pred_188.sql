-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (-1, 0), (2, 1), (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAG_FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS LEAD_FREE FROM CINEMA) AS A WHERE ((A.FREE - A.LAG_FREE) = 0 OR (A.FREE - A.LEAD_FREE) = 0) AND A.FREE = 1;

/*
Prediction Result:
(0,)
(2,)
*/