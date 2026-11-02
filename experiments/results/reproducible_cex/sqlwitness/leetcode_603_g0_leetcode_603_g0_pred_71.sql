-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 1), (1, 1), (3, 0), (4, 1), (5, 0), (6, 1), (7, 1), (8, 0), (9, 1), (10, 1), (11, 1), (12, 1), (13, 0), (14, 1), (15, 0), (16, 1), (17, 0), (18, 1);
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
(9,)
(10,)
(11,)
(12,)
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM CINEMA AS C1 WHERE C1.FREE = 1 AND EXISTS(SELECT * FROM CINEMA AS C2 WHERE ((C2.SEAT_ID + 1 = C1.SEAT_ID) OR (C2.SEAT_ID - 1 = C1.SEAT_ID)) AND C2.FREE = 1) ORDER BY C1.SEAT_ID ASC;

/*
Prediction Result:
(0,)
(1,)
(2,)
(6,)
(7,)
(9,)
(10,)
(11,)
(12,)
*/