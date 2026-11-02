-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 1), (2, 1), (1, 1), (3, 0), (4, 1), (5, 1), (6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(4,)
(5,)
(6,)
*/

-- Prediction Query
WITH T1 AS (SELECT SEAT_ID, FREE, LAG(FREE) OVER (ORDER BY SEAT_ID ASC) AS LAST_FREE, LEAD(FREE) OVER (ORDER BY SEAT_ID ASC) AS NEXT_FREE FROM CINEMA) SELECT SEAT_ID FROM T1 WHERE FREE = 1 AND (LAST_FREE = 1 OR NEXT_FREE = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(4,)
(5,)
(6,)
*/