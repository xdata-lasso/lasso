-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 1), (3, 0);
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
SELECT A.SEAT_ID FROM CINEMA AS A INNER JOIN CINEMA AS B ON (A.SEAT_ID - 1 = B.SEAT_ID) OR (A.SEAT_ID + 1 = B.SEAT_ID) WHERE A.FREE = 1 AND B.FREE = 1 GROUP BY 1 ORDER BY 1 ASC, A.SEAT_ID NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/