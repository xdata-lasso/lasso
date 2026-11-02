-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 1), (3, 0), (4, 0), (5, 1), (6, 0), (7, 0), (8, 1), (9, 0), (10, 1), (11, 1), (12, 1), (13, 0), (14, 0), (15, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(10,)
(11,)
(12,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT C1.SEAT_ID AS SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.SEAT_ID = C2.SEAT_ID + 1 AND C1.FREE = 1 AND C2.FREE = 1 UNION SELECT C2.SEAT_ID AS SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.SEAT_ID = C2.SEAT_ID + 1 AND C1.FREE = 1 AND C2.FREE = 1) AS A ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(10,)
(11,)
(12,)
*/