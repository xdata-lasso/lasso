-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (2, 1), (0, 1), (3, 1), (4, 0), (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM CINEMA AS C1 LEFT JOIN CINEMA AS C2 ON C1.SEAT_ID = C2.SEAT_ID - 1 LEFT JOIN CINEMA AS C3 ON C1.SEAT_ID = C3.SEAT_ID + 1 WHERE C1.FREE = 1 AND (C2.FREE = 1 OR C3.FREE = 1);

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
*/