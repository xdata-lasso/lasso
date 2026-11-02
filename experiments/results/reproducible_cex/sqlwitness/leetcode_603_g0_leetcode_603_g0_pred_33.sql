-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 0), (1, 1), (3, 1), (4, 1), (5, 0), (6, 1), (7, 1), (8, 0), (9, 1), (10, 0), (11, 0), (12, 1), (13, 1), (14, 1), (15, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
(3,)
(4,)
(6,)
(7,)
(12,)
(13,)
(14,)
*/

-- Prediction Query
SELECT DISTINCT C1.SEAT_ID FROM CINEMA AS C1 JOIN CINEMA AS C2 ON (C1.SEAT_ID = C2.SEAT_ID - 1 OR C1.SEAT_ID = C2.SEAT_ID + 1) AND C1.FREE = 1 AND C2.FREE = 1 ORDER BY C1.SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(6,)
(7,)
(12,)
(13,)
(14,)
*/