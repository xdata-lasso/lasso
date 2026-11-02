-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 0), (1, 1), (0, 1), (3, 1), (4, 1), (5, 0), (6, 1), (7, 0), (8, 0), (9, 0), (10, 0), (11, 0), (12, 1), (13, 0), (14, 1), (15, 1), (16, 1), (17, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(3,)
(4,)
(14,)
(15,)
(16,)
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) AS C1 WHERE C1.SEAT_ID + 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) OR C1.SEAT_ID - 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) ORDER BY C1.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(3,)
(4,)
(14,)
(15,)
(16,)
*/