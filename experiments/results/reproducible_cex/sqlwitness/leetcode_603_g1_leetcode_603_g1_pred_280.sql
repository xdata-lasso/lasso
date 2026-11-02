-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (1, 1);
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
WITH T1 AS (SELECT *, SEAT_ID - 1 FROM CINEMA WHERE FREE = 1) SELECT T1.SEAT_ID FROM T1 WHERE T1.SEAT_ID - 1 IN (SELECT T1.SEAT_ID FROM T1) OR T1.SEAT_ID + 1 IN (SELECT T1.SEAT_ID FROM T1);

/*
Prediction Result:
(1,)
(2,)
*/