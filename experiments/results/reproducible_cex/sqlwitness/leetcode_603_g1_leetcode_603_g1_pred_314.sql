-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (0, 1), (1, 1), (3, 1), (4, 1), (5, 0), (6, 1), (7, 1), (8, 0), (9, 0), (10, 0), (11, 1), (12, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(6,)
(7,)
*/

-- Prediction Query
WITH T AS (SELECT CASE WHEN T1.FREE = 1 AND ((SELECT FREE FROM CINEMA WHERE SEAT_ID = T1.SEAT_ID - 1 AND FREE = 1) OR ((SELECT FREE FROM CINEMA WHERE SEAT_ID = T1.SEAT_ID + 1 AND FREE = 1))) THEN T1.SEAT_ID ELSE NULL END AS C_SEATS FROM CINEMA AS T1) SELECT C_SEATS AS SEAT_ID FROM T WHERE NOT C_SEATS IS NULL;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
(6,)
(7,)
*/