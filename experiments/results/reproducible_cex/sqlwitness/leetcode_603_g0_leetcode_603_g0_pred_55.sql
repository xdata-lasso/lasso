-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (2, 1), (3, 0), (0, 1), (4, 0), (5, 0), (6, 0), (7, 0), (8, 1), (9, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(8,)
(9,)
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, SEAT_ID - ROW_NUMBER() OVER (ORDER BY SEAT_ID) AS FLAG FROM CINEMA WHERE FREE = 1), FLAG AS (SELECT FLAG FROM CTE GROUP BY FLAG HAVING COUNT(FLAG) >= 2) SELECT SEAT_ID FROM CTE JOIN FLAG ON CTE.FLAG = FLAG.FLAG ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(8,)
(9,)
*/