-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO cinema (seat_id, free) VALUES (1, NULL);
INSERT INTO cinema (seat_id, free) VALUES (2, NULL);
INSERT INTO cinema (seat_id, free) VALUES (3, 2);
INSERT INTO cinema (seat_id, free) VALUES (4, 2);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 2);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(7,)
(8,)
*/

-- Prediction Query
WITH CTE_1 AS (SELECT SEAT_ID, (SEAT_ID - DENSE_RANK() OVER (ORDER BY SEAT_ID)) AS MARKING FROM CINEMA WHERE FREE), CTE_2 AS (SELECT *, COUNT(*) OVER (PARTITION BY MARKING) AS CNT FROM CTE_1) SELECT SEAT_ID FROM CTE_2 WHERE CNT > 1;

/*
Prediction Result:
(3,)
(4,)
(5,)
(6,)
(7,)
(8,)
*/