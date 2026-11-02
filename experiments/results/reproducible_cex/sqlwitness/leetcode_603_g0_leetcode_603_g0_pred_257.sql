-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 0), (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT *, LEAD(FREE) OVER () AS NEXT_FREE, LAG(FREE) OVER () AS LAST_FREE FROM CINEMA) AS A WHERE (FREE = 1 AND NEXT_FREE = 1) OR (FREE = 1 AND LAST_FREE = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
*/