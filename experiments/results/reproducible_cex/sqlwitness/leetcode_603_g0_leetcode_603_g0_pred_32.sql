-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 0), (2, 1), (1, 1), (3, 0), (4, 0), (5, 1), (6, 0), (7, 1), (8, 0);
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
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A CROSS JOIN CINEMA AS B WHERE ABS(A.SEAT_ID - B.SEAT_ID) = 1 AND A.FREE = 1 AND B.FREE = 1 ORDER BY 1, A.SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
*/