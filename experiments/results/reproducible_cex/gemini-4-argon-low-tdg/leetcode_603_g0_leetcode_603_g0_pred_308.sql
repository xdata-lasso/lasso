-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO cinema (seat_id, free) VALUES (1, 0);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, NULL);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT *, SEAT_ID - ROW_NUMBER() OVER (ORDER BY SEAT_ID) AS RN FROM CINEMA WHERE FREE > 0), CTE2 AS (SELECT *, COUNT(*) OVER (PARTITION BY RN) AS C FROM CTE) SELECT SEAT_ID FROM CTE2 WHERE C >= 2;

/*
Prediction Result:
(5,)
(6,)
*/