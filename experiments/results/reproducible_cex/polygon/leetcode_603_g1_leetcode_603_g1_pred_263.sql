-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, SUM(FREE) OVER (ORDER BY SEAT_ID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS SM FROM CINEMA) AS T1 WHERE T1.SM > 1 AND T1.FREE = 1 ORDER BY 1 ASC, SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
*/