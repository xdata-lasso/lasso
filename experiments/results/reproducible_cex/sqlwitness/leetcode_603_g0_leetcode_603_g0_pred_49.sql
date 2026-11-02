-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 0), (1, 1), (0, 1), (3, 0), (4, 1), (5, 1), (6, 1), (7, 0), (8, 0), (9, 1), (10, 0), (11, 1), (12, 0), (13, 0), (14, 0), (15, 1), (16, 0), (17, 0), (18, 0), (19, 0), (20, 1), (21, 1), (22, 0), (23, 1), (24, 0), (25, 0), (26, 1), (27, 1), (28, 0), (29, 0), (30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(4,)
(5,)
(6,)
(20,)
(21,)
(26,)
(27,)
*/

-- Prediction Query
WITH "2_FREE" AS (SELECT SEAT_ID, FREE AS C_FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID ASC) AS CF_FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID ASC) AS CB_FREE FROM CINEMA ORDER BY SEAT_ID) SELECT SEAT_ID FROM "2_FREE" WHERE (C_FREE = 1 AND CF_FREE = 1) OR (C_FREE = 1 AND CB_FREE = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
(4,)
(5,)
(6,)
(20,)
(21,)
(26,)
(27,)
*/