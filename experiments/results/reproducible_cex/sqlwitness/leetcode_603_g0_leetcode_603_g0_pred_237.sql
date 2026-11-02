-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (2, 1), (0, 1), (3, 1), (4, 0), (5, 0), (6, 1), (7, 1), (8, 1), (9, 0), (10, 0), (11, 1), (12, 1), (13, 1), (14, 0), (15, 1), (16, 1);
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
(6,)
(7,)
(8,)
(11,)
(12,)
(13,)
(15,)
(16,)
*/

-- Prediction Query
SELECT DISTINCT X.SEAT_ID FROM CINEMA AS X CROSS JOIN CINEMA AS Y WHERE ABS(X.SEAT_ID - Y.SEAT_ID) = 1 AND X.FREE = TRUE AND Y.FREE = TRUE ORDER BY X.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(6,)
(7,)
(8,)
(11,)
(12,)
(13,)
(15,)
(16,)
*/