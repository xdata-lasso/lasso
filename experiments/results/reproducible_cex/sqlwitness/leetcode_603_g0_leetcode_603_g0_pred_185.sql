-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 0), (1, 1), (0, 1), (3, 1), (4, 1), (5, 0), (6, 1), (7, 0), (8, 0), (9, 1), (10, 0), (11, 1), (12, 1), (13, 0), (14, 0), (15, 0), (16, 0), (17, 0), (18, 1), (19, 0), (20, 0), (21, 1), (22, 1), (23, 0), (24, 1), (25, 0), (26, 0), (27, 0), (28, 0), (29, 0), (30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(3,)
(4,)
(11,)
(12,)
(21,)
(22,)
*/

-- Prediction Query
SELECT L.SEAT_ID FROM (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) AS L JOIN (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) AS R ON L.SEAT_ID = R.SEAT_ID - 1 OR L.SEAT_ID = R.SEAT_ID + 1 GROUP BY 1 ORDER BY 1, L.SEAT_ID NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
(3,)
(4,)
(11,)
(12,)
(21,)
(22,)
*/