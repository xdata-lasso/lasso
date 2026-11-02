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
WITH CTE AS (SELECT CASE WHEN (LAG(FREE) OVER (ORDER BY SEAT_ID) = 1 AND FREE = 1) THEN SEAT_ID WHEN (LEAD(FREE) OVER (ORDER BY SEAT_ID) = 1 AND FREE = 1) THEN SEAT_ID ELSE NULL END AS CONSECUTIVE_SEATS FROM CINEMA) SELECT CONSECUTIVE_SEATS AS SEAT_ID FROM CTE WHERE NOT CONSECUTIVE_SEATS IS NULL;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/