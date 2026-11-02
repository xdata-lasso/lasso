-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 0), (1, 1), (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A JOIN CINEMA AS B ON (A.SEAT_ID = B.SEAT_ID - 1 OR A.SEAT_ID = B.SEAT_ID + 1) AND A.FREE = 1 AND B.FREE = 1) SELECT * FROM TEMP;

/*
Prediction Result:
(2,)
(1,)
*/