-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 0), (3, 1), (4, 1), (5, 0), (6, 0), (7, 0), (8, 1), (9, 0), (10, 1), (11, 1), (12, 0), (13, 0), (14, 0), (15, 0), (16, 0), (17, 1), (18, 0), (19, 0), (20, 1), (21, 1), (22, 1);
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
(10,)
(11,)
(20,)
(21,)
(22,)
*/

-- Prediction Query
SELECT DISTINCT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.FREE = 1 AND C2.FREE = 1 AND ((C2.SEAT_ID = C1.SEAT_ID + 1) OR (C1.SEAT_ID = C2.SEAT_ID + 1)) ORDER BY C1.SEAT_ID ASC;

/*
Prediction Result:
(0,)
(1,)
(3,)
(4,)
(10,)
(11,)
(20,)
(21,)
(22,)
*/