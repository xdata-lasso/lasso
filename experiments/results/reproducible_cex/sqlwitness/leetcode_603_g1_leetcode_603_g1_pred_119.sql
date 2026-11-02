-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 0), (1, 1), (3, 0);
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
WITH CTE AS (SELECT SEAT_ID, FREE, LEAD(FREE) OVER () AS NEXT_, LAG(FREE) OVER () AS PREV_ FROM CINEMA) SELECT SEAT_ID FROM CTE WHERE (FREE = 1 AND NEXT_ = 1) OR (FREE = 1 AND PREV_ = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
*/