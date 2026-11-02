-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 2);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID AS SEAT_ID FROM CINEMA AS A JOIN CINEMA AS B ON ABS(A.SEAT_ID - B.SEAT_ID) = 1 AND A.FREE + B.FREE = 2 ORDER BY A.SEAT_ID, SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
*/