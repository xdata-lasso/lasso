-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (-1, 0), (1, 1), (0, 1), (3, 1), (4, 1), (5, 1), (6, 0), (7, 1), (8, 0), (9, 0), (10, 1), (11, 0), (12, 1), (13, 1), (14, 1), (15, 0), (16, 1), (17, 0), (18, 0);
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
(12,)
(13,)
(14,)
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM CINEMA AS C1 JOIN CINEMA AS C2 ON (C1.SEAT_ID = C2.SEAT_ID - 1 OR C1.SEAT_ID = C2.SEAT_ID + 1) AND C1.FREE = 1 AND C2.FREE = 1 GROUP BY 1 HAVING COUNT(*) > 0 ORDER BY 1, C1.SEAT_ID NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(5,)
(12,)
(13,)
(14,)
*/