-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 1), (2, 1), (1, 1), (3, 0), (4, 1), (5, 0), (6, 1), (7, 0), (8, 0), (9, 1), (10, 1), (11, 0), (12, 1), (13, 1), (14, 1), (15, 1), (16, 0), (17, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(9,)
(10,)
(12,)
(13,)
(14,)
(15,)
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A CROSS JOIN CINEMA AS B WHERE A.FREE = 1 AND B.FREE = 1 AND A.SEAT_ID + 1 = B.SEAT_ID OR A.FREE = 1 AND B.FREE = 1 AND A.SEAT_ID - 1 = B.SEAT_ID ORDER BY A.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(9,)
(10,)
(12,)
(13,)
(14,)
(15,)
*/