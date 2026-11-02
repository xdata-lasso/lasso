-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 0), (1, 1);
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
SELECT A.SEAT_ID FROM CINEMA AS A LEFT JOIN CINEMA AS B ON A.SEAT_ID = (B.SEAT_ID - 1) LEFT JOIN CINEMA AS C ON A.SEAT_ID = C.SEAT_ID + 1 WHERE A.FREE = 1 AND (B.FREE = 1 OR C.FREE = 1);

/*
Prediction Result:
(1,)
(2,)
*/