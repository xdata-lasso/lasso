-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (12, 2);
INSERT INTO "cinema" ("seat_id", "free") VALUES (13, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
WITH SEAT AS (SELECT SEAT_ID, FREE, SUM(FREE) OVER (ORDER BY SEAT_ID) - SEAT_ID AS GAP FROM CINEMA) SELECT SEAT_ID FROM SEAT WHERE GAP IN (SELECT GAP FROM SEAT WHERE FREE = 1 GROUP BY GAP HAVING COUNT(*) > 1) AND FREE = 1 ORDER BY SEAT_ID;

/*
Prediction Result:
(10,)
(13,)
*/