-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 0), (1, 1), (0, 1);
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
SELECT SEAT_ID FROM CINEMA AS C WHERE EXISTS(SELECT SEAT_ID FROM CINEMA WHERE (SEAT_ID = C.SEAT_ID + 1 AND FREE = 1) OR (SEAT_ID = C.SEAT_ID - 1 AND FREE = 1)) AND FREE = 1;

/*
Prediction Result:
(0,)
(1,)
*/