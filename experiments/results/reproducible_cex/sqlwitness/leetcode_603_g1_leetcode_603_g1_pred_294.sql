-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 0), (2, 1), (3, 1), (4, 1), (5, 0), (6, 1), (7, 1), (8, 0), (9, 0), (10, 0), (11, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
(3,)
(4,)
(6,)
(7,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LEAD(FREE) OVER () AS NEXT_ONE_AVAIL, LAG(FREE) OVER () AS PREV_ONE_AVAIL FROM CINEMA) AS PREVS WHERE FREE = 1 AND (PREV_ONE_AVAIL = 1 OR NEXT_ONE_AVAIL = 1) ORDER BY SEAT_ID ASC;

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(6,)
(7,)
*/