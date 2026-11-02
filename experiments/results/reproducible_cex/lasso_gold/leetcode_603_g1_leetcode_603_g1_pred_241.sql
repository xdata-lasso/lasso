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
WITH CONSECUTIVE_SEAT AS (SELECT SEAT_ID, FREE, LEAD(FREE) OVER (ORDER BY SEAT_ID) AS PREVIOUS_SEAT, LAG(FREE) OVER (ORDER BY SEAT_ID) AS NEXT_SEAT FROM CINEMA) SELECT SEAT_ID FROM CONSECUTIVE_SEAT WHERE PREVIOUS_SEAT = 1 AND FREE = 1 OR NEXT_SEAT = 1 AND FREE = 1 ORDER BY SEAT_ID;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/