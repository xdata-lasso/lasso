-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (1075, 2);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1076, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1077, 5);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1078, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM CINEMA WHERE FREE = 1 AND (SEAT_ID + 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) OR SEAT_ID - 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE - 0)) ORDER BY SEAT_ID;

/*
Prediction Result:
(1076,)
(1078,)
*/