-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (1, 1), (0, 0), (3, 0), (4, 1), (5, 0), (6, 1), (7, 0), (8, 1), (9, 1), (10, 1), (11, 0), (12, 1), (13, 0), (14, 0), (15, 0), (16, 1), (17, 1), (18, 1), (19, 0), (20, 1), (21, 1), (22, 1), (23, 0), (24, 0), (25, 0), (26, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
(8,)
(9,)
(10,)
(16,)
(17,)
(18,)
(20,)
(21,)
(22,)
*/

-- Prediction Query
WITH CTE AS (SELECT SEAT_ID, FREE, LAG(FREE) OVER (ORDER BY SEAT_ID) AS PREV, LEAD(FREE) OVER (ORDER BY SEAT_ID) AS NEXT FROM CINEMA) SELECT DISTINCT SEAT_ID FROM CTE WHERE FREE = 1 AND PREV = FREE OR FREE = 1 AND NEXT = FREE ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(8,)
(9,)
(10,)
(16,)
(17,)
(18,)
(20,)
(21,)
(22,)
*/