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
WITH BASE AS (SELECT SEAT_ID, FREE, LEAD(FREE) OVER (ORDER BY SEAT_ID) AS L1, LAG(FREE) OVER (ORDER BY SEAT_ID) AS L2 FROM CINEMA) SELECT C.SEAT_ID FROM CINEMA AS C INNER JOIN BASE AS B ON B.SEAT_ID = C.SEAT_ID WHERE (C.FREE <> 0 AND B.L1 = 1) OR (C.FREE <> 0 AND B.L2 = 1);

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/