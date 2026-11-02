-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT *, COALESCE(LAG(FREE) OVER (ORDER BY SEAT_ID), 0) AS PREV, COALESCE(LEAD(FREE) OVER (ORDER BY SEAT_ID), 0) AS NEXT FROM CINEMA) AS T WHERE FREE = 1 AND (PREV = 1 OR NEXT = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(3,)
*/