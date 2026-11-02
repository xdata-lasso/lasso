-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 2);
INSERT INTO cinema (seat_id, free) VALUES (2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.SEAT_ID FROM CINEMA AS C LEFT JOIN CINEMA AS C1 ON C.SEAT_ID - 1 = C1.SEAT_ID LEFT JOIN CINEMA AS C2 ON C.SEAT_ID + 1 = C2.SEAT_ID WHERE C.FREE AND (COALESCE(C1.FREE, FALSE) OR COALESCE(C2.FREE, FALSE));

/*
Prediction Result:
(1,)
(2,)
*/