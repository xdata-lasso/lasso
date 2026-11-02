-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (2, 1), (0, 1), (3, 0), (4, 0), (5, 0), (6, 1), (7, 1), (8, 0), (9, 1), (10, 0), (11, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(6,)
(7,)
*/

-- Prediction Query
SELECT X.SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAST_FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXT_FREE FROM CINEMA) AS X WHERE (X.FREE = 1 AND X.LAST_FREE = 1) OR (X.FREE = 1 AND X.NEXT_FREE = 1) ORDER BY X.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(6,)
(7,)
*/