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
WITH CTE AS (SELECT *, SUM(FREE) OVER (ORDER BY SEAT_ID ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS COUNT_PRECEDING, SUM(FREE) OVER (ORDER BY SEAT_ID ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS COUNT_FOLLOWING FROM CINEMA) SELECT SEAT_ID FROM CTE WHERE COUNT_PRECEDING > 1 OR COUNT_FOLLOWING > 1;

/*
Prediction Result:
(1,)
(3,)
*/