-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 2);
INSERT INTO cinema (seat_id, free) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM CINEMA AS C1 WHERE C1.FREE = 1 AND (1 = (SELECT C2.FREE FROM CINEMA AS C2 WHERE C2.SEAT_ID = C1.SEAT_ID + 1) OR (SELECT C3.FREE FROM CINEMA AS C3 WHERE C3.SEAT_ID = C1.SEAT_ID - 1)) ORDER BY SEAT_ID;

/*
Prediction Result:
(2,)
*/