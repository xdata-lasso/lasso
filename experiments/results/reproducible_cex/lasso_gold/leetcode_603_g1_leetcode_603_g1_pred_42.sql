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
SELECT T1.SEAT_ID FROM (SELECT SEAT_ID, FREE, COALESCE(LAG(FREE) OVER (), 0) AS PREVIOUS_SEAT_FREE, COALESCE(LEAD(FREE) OVER (), 0) AS NEXT_SEAT_FREE FROM CINEMA) AS T1 WHERE T1.FREE = 1 AND (T1.PREVIOUS_SEAT_FREE = 1 OR T1.NEXT_SEAT_FREE) ORDER BY T1.SEAT_ID;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/