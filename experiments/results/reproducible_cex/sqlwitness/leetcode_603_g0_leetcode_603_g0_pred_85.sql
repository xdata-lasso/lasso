-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (1, 1), (0, 0), (3, 1), (4, 0), (5, 1), (6, 1), (7, 0), (8, 0), (9, 0), (10, 1), (11, 0);
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
*/

-- Prediction Query
SELECT DISTINCT C1.SEAT_ID FROM CINEMA AS C1 INNER JOIN CINEMA AS C2 ON ABS(C2.SEAT_ID - C1.SEAT_ID) = 1 WHERE C1.FREE = 1 AND C2.FREE = 1 ORDER BY C1.SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(3,)
(5,)
(6,)
*/