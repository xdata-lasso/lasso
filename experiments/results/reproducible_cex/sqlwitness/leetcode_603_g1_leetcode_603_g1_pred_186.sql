-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 1), (2, 1), (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT NEXT_FREE AS SEAT_ID FROM (SELECT SEAT_ID, LEAD(SEAT_ID) OVER () AS NEXT_FREE FROM CINEMA WHERE FREE = 1) AS R WHERE NEXT_FREE - SEAT_ID = 1 UNION SELECT DISTINCT SEAT_ID FROM (SELECT SEAT_ID, LEAD(SEAT_ID) OVER () AS NEXT_FREE FROM CINEMA WHERE FREE = 1) AS R WHERE ABS(SEAT_ID - NEXT_FREE) = 1 ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/