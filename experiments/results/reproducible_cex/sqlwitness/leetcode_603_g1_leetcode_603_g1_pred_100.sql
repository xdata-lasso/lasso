-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 0), (1, 0), (3, 1), (4, 1), (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(2,)
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER () AS NXT, LAG(FREE, 1) OVER () AS PREV FROM CINEMA) AS A WHERE (FREE = NXT OR FREE = PREV) AND FREE = 1 ORDER BY SEAT_ID;

/*
Prediction Result:
(2,)
(3,)
(4,)
(5,)
*/