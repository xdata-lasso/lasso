-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 0), (1, 1), (3, 1), (4, 0), (5, 0), (6, 1), (7, 1), (8, 1), (9, 0), (10, 0), (11, 0), (12, 0), (13, 0), (14, 1), (15, 1), (16, 1), (17, 0), (18, 1), (19, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
(3,)
(6,)
(7,)
(8,)
(14,)
(15,)
(16,)
(18,)
(19,)
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXT_SEAT, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS PREV_SEAT FROM CINEMA) SELECT SEAT_ID FROM CTE WHERE (FREE = 1 AND NEXT_SEAT = 1) OR (FREE = 1 AND PREV_SEAT = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(3,)
(6,)
(7,)
(8,)
(14,)
(15,)
(16,)
(18,)
(19,)
*/