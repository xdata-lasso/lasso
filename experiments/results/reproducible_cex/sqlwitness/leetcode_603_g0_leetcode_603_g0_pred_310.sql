-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (3, 1), (2, 0), (-1, 0), (4, 0), (5, 0), (6, 0), (7, 1), (8, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(7,)
(8,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXT_FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS PRE_FREE FROM CINEMA) AS SUB WHERE SUB.FREE > 0 AND SUB.FREE + COALESCE(SUB.NEXT_FREE, 0) + COALESCE(SUB.PRE_FREE, 0) >= 2 ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(7,)
(8,)
*/