-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (3, 1), (0, 1), (1, 1), (4, 1), (5, 1), (6, 1), (7, 0), (8, 0), (9, 1), (10, 0), (11, 0), (12, 1), (13, 0), (14, 1), (15, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(5,)
(6,)
*/

-- Prediction Query
SELECT C.SEAT_ID FROM (SELECT B.SEAT_ID, COUNT(*) OVER (PARTITION BY B.DIFF) AS CT FROM (SELECT A.SEAT_ID, (A.SEAT_ID - A.NUM) AS DIFF FROM (SELECT *, ROW_NUMBER() OVER () AS NUM FROM CINEMA WHERE FREE = 1) AS A) AS B) AS C WHERE C.CT >= 2;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(5,)
(6,)
*/