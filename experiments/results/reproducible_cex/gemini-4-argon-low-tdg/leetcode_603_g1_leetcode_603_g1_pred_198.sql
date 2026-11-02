-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests strictness of `free = TRUE` (which is `free = 1` in SQLite) against NULL, 0, and truthy non-1 integers like 2 or -1.
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 2);
INSERT INTO cinema (seat_id, free) VALUES (3, -1);
INSERT INTO cinema (seat_id, free) VALUES (4, NULL);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE (C1.SEAT_ID = C2.SEAT_ID + 1 OR C1.SEAT_ID = C2.SEAT_ID - 1) AND C1.FREE AND C2.FREE ORDER BY C1.SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(3,)
*/