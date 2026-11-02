-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 0);
INSERT INTO cinema (seat_id, free) VALUES (6, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 1);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
(8,)
(9,)
(10,)
*/

-- Prediction Query
WITH T_LEAD_LAG AS (SELECT LEAD(C.FREE) OVER (ORDER BY C.SEAT_ID) AS LEAD_ID, LAG(C.FREE) OVER (ORDER BY C.SEAT_ID) AS LAG_ID, C.SEAT_ID, C.FREE FROM CINEMA AS C) SELECT CTE.SEAT_ID FROM T_LEAD_LAG AS CTE WHERE (CTE.LEAD_ID = 1 AND CTE.FREE = 1) OR (CTE.LAG_ID = 1 AND CTE.FREE = 1) ORDER BY CTE.SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(4,)
(6,)
(8,)
(9,)
(10,)
*/