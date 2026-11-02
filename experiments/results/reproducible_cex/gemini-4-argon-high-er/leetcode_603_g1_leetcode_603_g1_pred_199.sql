-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT *, LAG(FREE) OVER (ORDER BY SEAT_ID) AS LAGFREE, LEAD(FREE) OVER (ORDER BY SEAT_ID) AS LEADINGFREE FROM CINEMA) AS A WHERE (FREE = 1 AND LEADINGFREE = 1) OR (FREE = 1 AND LAGFREE = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(3,)
*/