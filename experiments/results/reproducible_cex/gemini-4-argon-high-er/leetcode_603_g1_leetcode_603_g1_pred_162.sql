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
SELECT SEAT_ID FROM CINEMA AS C WHERE FREE AND (EXISTS(SELECT * FROM CINEMA WHERE SEAT_ID = C.SEAT_ID - 1 AND FREE) OR EXISTS(SELECT * FROM CINEMA WHERE SEAT_ID = C.SEAT_ID + 1 AND FREE));

/*
Prediction Result:
(1,)
(2,)
*/