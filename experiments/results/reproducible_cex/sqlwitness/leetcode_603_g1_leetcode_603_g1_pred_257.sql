-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 1), (1, 1), (3, 1), (4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
(4,)
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, SEAT_ID - ROW_NUMBER() OVER () AS ROW_DIFF FROM CINEMA WHERE FREE = 1) SELECT SEAT_ID FROM (SELECT SEAT_ID, COUNT(SEAT_ID) OVER (PARTITION BY ROW_DIFF) AS NUM FROM CTE) AS A WHERE NUM > 1;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
*/