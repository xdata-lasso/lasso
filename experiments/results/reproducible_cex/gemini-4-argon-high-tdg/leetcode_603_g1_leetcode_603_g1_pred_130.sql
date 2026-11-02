-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 1);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(3,)
(4,)
(6,)
(7,)
(8,)
*/

-- Prediction Query
WITH T1 AS (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS L1, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS L2 FROM CINEMA) SELECT SEAT_ID FROM T1 WHERE FREE = TRUE AND (L1 = TRUE OR L2 = TRUE) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(3,)
(4,)
(6,)
(7,)
(8,)
(10,)
*/