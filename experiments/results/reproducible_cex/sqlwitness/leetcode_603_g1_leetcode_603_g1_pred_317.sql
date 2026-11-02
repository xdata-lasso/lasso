-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 0), (1, 1), (0, 1), (3, 1), (4, 0), (5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
WITH SEAT_FREE AS (SELECT SEAT_ID, FREE, LAG(FREE) OVER () AS PREV, LEAD(FREE) OVER () AS NEXT FROM CINEMA) SELECT SEAT_ID FROM SEAT_FREE WHERE FREE = 1 AND (PREV = 1 OR NEXT = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
*/