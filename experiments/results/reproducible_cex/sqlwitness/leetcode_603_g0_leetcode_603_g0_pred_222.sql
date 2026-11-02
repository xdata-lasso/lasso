-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 1), (2, 1), (1, 1), (3, 1), (4, 1), (5, 0), (6, 1);
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
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS PREVIOUS_SEAT, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXT_SEAT FROM CINEMA) SELECT SEAT_ID FROM CTE WHERE FREE = 1 AND (PREVIOUS_SEAT = 1 OR NEXT_SEAT = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
*/