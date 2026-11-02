-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (-10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1002, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (11, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(10,)
(11,)
*/

-- Prediction Query
WITH CTE AS (SELECT *, LAG(FREE, 1, 0) OVER (ORDER BY SEAT_ID ASC) AS PREVIOUS_NODE, LEAD(FREE, 1, 0) OVER (ORDER BY SEAT_ID ASC) AS NEXT_NODE FROM CINEMA) SELECT SEAT_ID FROM CTE WHERE (FREE AND PREVIOUS_NODE) OR (FREE AND NEXT_NODE) ORDER BY SEAT_ID;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/