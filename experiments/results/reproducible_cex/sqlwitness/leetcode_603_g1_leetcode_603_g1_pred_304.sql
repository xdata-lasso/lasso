-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 1), (2, 0), (1, 1), (3, 1), (4, 0), (5, 1), (6, 0), (7, 1), (8, 0), (9, 0), (10, 1), (11, 0), (12, 1);
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
SELECT SEAT_ID FROM (SELECT *, LAG(FREE) OVER () AS PREVIOUS, LEAD(FREE) OVER () AS LATER FROM CINEMA) AS A WHERE (FREE = 1 AND PREVIOUS = 1) OR (FREE = 1 AND LATER = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
*/