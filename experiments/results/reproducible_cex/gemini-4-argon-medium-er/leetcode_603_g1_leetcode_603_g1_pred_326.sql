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
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS P_SEAT, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS F_SEAT FROM CINEMA) AS A WHERE A.FREE = 1 AND A.P_SEAT = 1 OR A.FREE = 1 AND A.F_SEAT = 1 ORDER BY A.SEAT_ID, SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(3,)
*/