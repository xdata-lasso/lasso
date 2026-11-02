-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (1, 1), (0, 0), (3, 1), (4, 1), (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
(3,)
(4,)
(5,)
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) SELECT SEAT_ID FROM CTE WHERE (SEAT_ID + 1 IN (SELECT SEAT_ID FROM CTE) OR SEAT_ID - 1 IN (SELECT SEAT_ID FROM CTE));

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(5,)
*/