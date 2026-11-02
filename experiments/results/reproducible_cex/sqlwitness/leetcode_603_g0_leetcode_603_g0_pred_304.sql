-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 1), (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT C.SEAT_ID FROM CINEMA AS C JOIN CINEMA AS C1 ON ABS(C.SEAT_ID - C1.SEAT_ID) = 1 WHERE C.FREE = 1 AND C1.FREE = 1 ORDER BY 1, C.SEAT_ID NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/