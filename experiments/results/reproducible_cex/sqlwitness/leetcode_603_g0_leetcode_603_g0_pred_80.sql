-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (1, 1), (0, 1), (3, 1), (4, 0), (5, 0), (6, 0), (7, 1), (8, 0), (9, 1), (10, 1), (11, 1), (12, 0);
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
(9,)
(10,)
(11,)
*/

-- Prediction Query
SELECT DISTINCT B.SEAT_ID FROM CINEMA AS A JOIN CINEMA AS B ON ABS(A.SEAT_ID - B.SEAT_ID) = 1 AND A.FREE = 1 AND B.FREE = 1 ORDER BY B.SEAT_ID ASC;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(9,)
(10,)
(11,)
*/