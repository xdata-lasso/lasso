-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 8
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 2);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(3,)
(4,)
*/

-- Prediction Query
WITH CTE_1 AS (SELECT SEAT_ID, (SEAT_ID - DENSE_RANK() OVER (ORDER BY SEAT_ID)) AS MARKING FROM CINEMA WHERE FREE), CTE_2 AS (SELECT *, COUNT(*) OVER (PARTITION BY MARKING) AS CNT FROM CTE_1) SELECT SEAT_ID FROM CTE_2 WHERE CNT > 1;

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
*/