-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 0);
INSERT INTO cinema (seat_id, free) VALUES (6, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 1);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
(8,)
(9,)
(10,)
*/

-- Prediction Query
SELECT C.SEAT_ID FROM (SELECT SEAT_ID, FREE, COALESCE(LEAD(FREE) OVER (), NOT FREE) AS NEXT, COALESCE(LAG(FREE) OVER (), NOT FREE) AS PREVIOUS FROM CINEMA) AS C WHERE C.FREE = 1 AND (C.FREE = C.NEXT OR C.FREE = C.PREVIOUS) ORDER BY C.SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(4,)
(6,)
(8,)
(9,)
(10,)
*/