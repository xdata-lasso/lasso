-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT DISTINCT C2.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE ABS(C2.SEAT_ID - C1.SEAT_ID) = 1 AND C2.FREE = TRUE AND C1.FREE = TRUE;

/*
Prediction Result:
(4,)
(3,)
(5,)
*/