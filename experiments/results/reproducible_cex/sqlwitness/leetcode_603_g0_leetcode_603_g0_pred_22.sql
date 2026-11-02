-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 1), (2, 1), (1, 1);
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
SELECT DISTINCT S.SEAT_ID FROM CINEMA AS S LEFT JOIN CINEMA AS S1 ON S.SEAT_ID + 1 = S1.SEAT_ID OR S.SEAT_ID - 1 = S1.SEAT_ID WHERE (S.FREE = 1 AND S1.FREE = 1) ORDER BY S.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/