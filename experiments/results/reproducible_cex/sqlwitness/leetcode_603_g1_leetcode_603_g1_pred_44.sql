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
SELECT DISTINCT SEAT_ID FROM (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXTFREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS BEFOREFREE FROM CINEMA) AS T WHERE ((FREE = 1 AND NEXTFREE = 1) OR (FREE = 1 AND BEFOREFREE = 1)) ORDER BY 1, SEAT_ID NULLS LAST;

/*
Prediction Result:
(0,)
(2,)
*/