-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 0), (1, 1), (3, 1), (4, 0), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 0), (11, 0), (12, 0), (13, 0), (14, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
(3,)
(5,)
(6,)
(7,)
(8,)
(9,)
*/

-- Prediction Query
SELECT SEAT_ID FROM CINEMA WHERE FREE = 1 AND (SEAT_ID - 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) OR SEAT_ID + 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1));

/*
Prediction Result:
(1,)
(2,)
(3,)
(5,)
(6,)
(7,)
(8,)
(9,)
*/