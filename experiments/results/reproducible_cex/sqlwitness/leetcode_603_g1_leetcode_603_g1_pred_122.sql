-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS "1ST", LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS "2ND" FROM CINEMA) SELECT SEAT_ID FROM CTE AS A WHERE (A.FREE = 1 AND A."1ST" = 1) OR (A.FREE = 1 AND A."2ND" = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(2,)
*/