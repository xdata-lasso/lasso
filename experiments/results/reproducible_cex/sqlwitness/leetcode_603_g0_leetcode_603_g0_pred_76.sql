-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 0), (3, 1), (4, 0), (5, 1), (6, 0), (7, 1), (8, 0), (9, 0), (10, 0), (11, 1), (12, 0), (13, 0), (14, 1), (15, 0), (16, 0), (17, 0), (18, 0), (19, 1), (20, 1), (21, 1), (22, 0), (23, 0), (24, 0), (25, 0), (26, 1), (27, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(19,)
(20,)
(21,)
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A JOIN CINEMA AS B ON ((A.SEAT_ID - B.SEAT_ID) = 1 OR (B.SEAT_ID - A.SEAT_ID) = 1) AND A.FREE AND B.FREE ORDER BY A.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(19,)
(20,)
(21,)
*/