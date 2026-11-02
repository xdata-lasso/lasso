-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 0), (2, 1), (3, 1), (4, 0), (5, 1), (6, 1), (7, 0);
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
*/

-- Prediction Query
WITH CT AS (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER () AS LD, LAG(FREE, 1) OVER () AS LG FROM CINEMA) SELECT SEAT_ID FROM CT WHERE FREE * LD = 1 OR FREE * LG = 1;

/*
Prediction Result:
(1,)
(2,)
(3,)
(5,)
(6,)
*/