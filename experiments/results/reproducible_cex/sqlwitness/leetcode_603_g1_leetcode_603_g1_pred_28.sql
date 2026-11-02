-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT CINEMA.SEAT_ID FROM CINEMA LEFT JOIN CINEMA AS B ON B.SEAT_ID = CINEMA.SEAT_ID + 1 LEFT JOIN CINEMA AS C ON C.SEAT_ID = CINEMA.SEAT_ID - 1 WHERE CINEMA.FREE = 1 AND (B.FREE = 1 OR C.FREE = 1);

/*
Prediction Result:
(0,)
(1,)
*/