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
SELECT S1.SEAT_ID FROM CINEMA AS S1 LEFT JOIN CINEMA AS S2 ON S1.SEAT_ID = S2.SEAT_ID - 1 LEFT JOIN CINEMA AS S3 ON S1.SEAT_ID = S3.SEAT_ID + 1 WHERE S1.FREE = 1 AND (S2.FREE = 1 OR S3.FREE = 1);

/*
Prediction Result:
(1,)
(2,)
*/