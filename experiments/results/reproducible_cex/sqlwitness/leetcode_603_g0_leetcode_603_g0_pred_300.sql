-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 0), (2, 1), (1, 1), (3, 0), (4, 1), (5, 1), (6, 0), (7, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
(4,)
(5,)
*/

-- Prediction Query
SELECT SEAT_ID FROM CINEMA WHERE FREE = TRUE AND (SEAT_ID + 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE = TRUE) OR SEAT_ID - 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE = TRUE)) ORDER BY SEAT_ID ASC;

/*
Prediction Result:
(1,)
(2,)
(4,)
(5,)
*/