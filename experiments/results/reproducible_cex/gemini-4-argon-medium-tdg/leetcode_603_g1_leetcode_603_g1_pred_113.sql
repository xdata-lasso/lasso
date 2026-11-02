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
WITH BASE AS (SELECT SEAT_ID, FREE, LEAD(FREE) OVER (ORDER BY SEAT_ID) AS L1, LAG(FREE) OVER (ORDER BY SEAT_ID) AS L2 FROM CINEMA) SELECT C.SEAT_ID FROM CINEMA AS C INNER JOIN BASE AS B ON B.SEAT_ID = C.SEAT_ID WHERE (C.FREE <> 0 AND B.L1 = 1) OR (C.FREE <> 0 AND B.L2 = 1);

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