-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 1), (3, 1), (4, 0), (5, 1), (6, 1), (7, 0), (8, 0), (9, 0), (10, 0), (11, 1), (12, 0), (13, 1), (14, 0), (15, 1), (16, 1), (17, 1), (18, 1), (19, 0), (20, 1), (21, 0), (22, 0), (23, 1), (24, 0), (25, 1), (26, 0);
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
(5,)
(6,)
(15,)
(16,)
(17,)
(18,)
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NXT, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS PRV FROM CINEMA) SELECT DISTINCT SEAT_ID FROM CTE WHERE (FREE = 1 AND PRV = 1) OR (FREE = 1 AND NXT = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(5,)
(6,)
(15,)
(16,)
(17,)
(18,)
*/