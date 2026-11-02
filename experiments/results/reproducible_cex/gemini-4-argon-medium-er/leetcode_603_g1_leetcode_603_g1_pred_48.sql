-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER () AS NEXT, LAG(FREE, 1) OVER () AS PREV FROM CINEMA) AS A WHERE A.FREE = TRUE AND (NEXT = TRUE OR PREV = TRUE) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(3,)
*/