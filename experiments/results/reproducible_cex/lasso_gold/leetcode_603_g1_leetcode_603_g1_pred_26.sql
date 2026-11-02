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
SELECT C1.SEAT_ID FROM CINEMA AS C1 INNER JOIN (SELECT SEAT_ID, SUM(FREE) OVER (ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS SUM_FREE_B, SUM(FREE) OVER (ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS SUM_FREE_F FROM CINEMA AS C2) AS C2 ON C1.SEAT_ID = C2.SEAT_ID WHERE C2.SUM_FREE_B >= 2 OR C2.SUM_FREE_F >= 2;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/