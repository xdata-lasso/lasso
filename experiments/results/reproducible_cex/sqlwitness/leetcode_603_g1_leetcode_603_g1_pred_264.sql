-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 1), (2, 1), (1, 0), (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT *, LEAD(FREE) OVER () AS BEF, LAG(FREE) OVER () AS AFT FROM CINEMA) AS T1 WHERE FREE = 1 AND (BEF = 1 OR AFT = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(2,)
(3,)
*/