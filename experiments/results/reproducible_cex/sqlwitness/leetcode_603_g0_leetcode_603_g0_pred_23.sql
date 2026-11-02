-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 0), (1, 1), (0, 1), (3, 1), (4, 0);
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
SELECT DISTINCT T1.SEAT_ID FROM CINEMA AS T1 INNER JOIN CINEMA AS T2 ON ABS(T1.SEAT_ID - T2.SEAT_ID) = 1 AND T1.FREE = 1 AND T2.FREE = 1 ORDER BY T1.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
*/