-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (3, 1), (0, 1), (1, 0), (2, 0), (4, 1), (5, 0), (6, 0), (7, 1), (8, 1), (9, 0), (10, 0), (11, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(3,)
(4,)
(7,)
(8,)
*/

-- Prediction Query
SELECT C.SEAT_ID FROM (SELECT B.SEAT_ID, COUNT(*) OVER (PARTITION BY B.DIFF) AS CT FROM (SELECT A.SEAT_ID, (A.SEAT_ID - A.NUM) AS DIFF FROM (SELECT *, ROW_NUMBER() OVER () AS NUM FROM CINEMA WHERE FREE = 1) AS A) AS B) AS C WHERE C.CT >= 2;

/*
Prediction Result:
(3,)
(4,)
(7,)
(8,)
*/