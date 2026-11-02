-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 0), (1, 1), (0, 1), (3, 0), (4, 0), (5, 1), (6, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, SEAT_ID - ROW_NUMBER() OVER () AS ROW_DIFF FROM CINEMA WHERE FREE = 1) SELECT SEAT_ID FROM (SELECT SEAT_ID, COUNT(SEAT_ID) OVER (PARTITION BY ROW_DIFF) AS NUM FROM CTE) AS A WHERE NUM > 1;

/*
Prediction Result:
(0,)
(1,)
*/