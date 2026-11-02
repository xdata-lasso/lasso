-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (-10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1002, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (11, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(10,)
(11,)
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, FREE, (FREE - LEAD(FREE) OVER (ORDER BY SEAT_ID)) AS DIFF_LEAD_FREE, (FREE - LAG(FREE) OVER (ORDER BY SEAT_ID)) AS DIFF_LAG_FREE FROM CINEMA) SELECT SEAT_ID FROM CTE WHERE FREE <> 0 AND (DIFF_LEAD_FREE = 0 OR DIFF_LAG_FREE = 0);

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/