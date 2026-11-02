-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 0), (2, 1), (1, 1), (3, 1), (4, 0), (5, 0), (6, 0), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1), (14, 0), (15, 1), (16, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
(3,)
(7,)
(8,)
(9,)
(10,)
(11,)
(12,)
(13,)
*/

-- Prediction Query
SELECT * FROM (SELECT C1.SEAT_ID FROM CINEMA AS C1 JOIN CINEMA AS C2 ON C1.SEAT_ID = C2.SEAT_ID - 1 AND C1.FREE = C2.FREE WHERE C1.FREE = 1 UNION SELECT C2.SEAT_ID FROM CINEMA AS C1 JOIN CINEMA AS C2 ON C1.SEAT_ID = C2.SEAT_ID - 1 AND C1.FREE = C2.FREE WHERE C1.FREE = 1) AS HFHF ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(3,)
(7,)
(8,)
(9,)
(10,)
(11,)
(12,)
(13,)
*/