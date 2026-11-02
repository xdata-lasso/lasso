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
WITH CTE_FREE AS (SELECT SEAT_ID, FREE, LAG(FREE) OVER (ORDER BY SEAT_ID) AS BE, LEAD(FREE) OVER (ORDER BY SEAT_ID) AS AF FROM CINEMA) SELECT SEAT_ID FROM CTE_FREE WHERE FREE + BE = 2 OR FREE + AF = 2;

/*
Prediction Result:
(1,)
(3,)
*/