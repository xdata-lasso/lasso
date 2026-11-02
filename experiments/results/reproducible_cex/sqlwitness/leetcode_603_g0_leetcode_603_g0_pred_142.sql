-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 0), (3, 1), (1, 1), (2, 1), (4, 0), (5, 1), (6, 1), (7, 0), (8, 1), (9, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
(3,)
(5,)
(6,)
(8,)
(9,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, COUNT(*) OVER (PARTITION BY NUMBER) AS TOTAL_ROWS FROM (SELECT SEAT_ID - ROW_NUMBER() OVER (ORDER BY SEAT_ID) AS NUMBER, SEAT_ID FROM CINEMA WHERE FREE = 1) AS T0) AS T1 WHERE TOTAL_ROWS >= 2 ORDER BY 1, SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
(3,)
(5,)
(6,)
(8,)
(9,)
*/