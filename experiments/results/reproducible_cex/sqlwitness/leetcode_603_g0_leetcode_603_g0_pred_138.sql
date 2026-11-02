-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (2, 1), (0, 1), (3, 1), (4, 1), (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT DISTINCT ORIGINAL.SEAT_ID FROM CINEMA AS ORIGINAL JOIN CINEMA AS SELF_JOIN ON ABS(ORIGINAL.SEAT_ID - SELF_JOIN.SEAT_ID) = 1 WHERE ORIGINAL.FREE = '1' AND SELF_JOIN.FREE = '1' ORDER BY ORIGINAL.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(5,)
*/