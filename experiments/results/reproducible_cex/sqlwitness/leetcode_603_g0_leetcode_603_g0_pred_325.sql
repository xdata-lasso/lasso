-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 1), (3, 0), (4, 0), (5, 0), (6, 1), (7, 1), (8, 1), (9, 1), (10, 0), (11, 0), (12, 1), (13, 1), (14, 1), (15, 0), (16, 0), (17, 0), (18, 0), (19, 0), (20, 1), (21, 0), (22, 1), (23, 0), (24, 0), (25, 1), (26, 1), (27, 1), (28, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(6,)
(7,)
(8,)
(9,)
(12,)
(13,)
(14,)
(25,)
(26,)
(27,)
*/

-- Prediction Query
SELECT SEAT_ID FROM CINEMA AS C1 WHERE C1.FREE = 1 AND EXISTS(SELECT * FROM CINEMA AS C2 WHERE FREE = 1 AND (C1.SEAT_ID = C2.SEAT_ID - 1 OR C1.SEAT_ID = C2.SEAT_ID + 1)) ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(2,)
(6,)
(7,)
(8,)
(9,)
(12,)
(13,)
(14,)
(25,)
(26,)
(27,)
*/