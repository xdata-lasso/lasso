-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 1);
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
SELECT DISTINCT CINEMA.SEAT_ID FROM CINEMA JOIN CINEMA AS C ON ABS(CINEMA.SEAT_ID - C.SEAT_ID) = 1 WHERE CINEMA.FREE = 1 AND C.FREE = 1 ORDER BY CINEMA.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/