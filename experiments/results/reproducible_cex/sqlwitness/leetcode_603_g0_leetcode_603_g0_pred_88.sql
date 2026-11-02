-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 0), (1, 1), (3, 0), (4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT S1.SEAT_ID AS SEAT_ID FROM CINEMA AS S1 JOIN CINEMA AS S2 ON S1.SEAT_ID = S2.SEAT_ID + 1 OR S1.SEAT_ID = S2.SEAT_ID - 1 WHERE S1.FREE = 1 AND S2.FREE = 1 ORDER BY S1.SEAT_ID, SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
*/