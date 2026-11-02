-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
(2,)
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM CINEMA AS C1 LEFT JOIN CINEMA AS C2 ON C1.SEAT_ID + 1 = C2.SEAT_ID LEFT JOIN CINEMA AS C3 ON C1.SEAT_ID - 1 = C3.SEAT_ID WHERE C1.FREE = 1 AND (C2.FREE = 1 OR C3.FREE = 1);

/*
Prediction Result:
(0,)
(1,)
(2,)
*/