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
WITH T1 AS (SELECT SEAT_ID, FREE, ROW_NUMBER() OVER (ORDER BY SEAT_ID) AS RN, SEAT_ID - (ROW_NUMBER() OVER (ORDER BY SEAT_ID)) AS DIFF FROM CINEMA WHERE FREE <> 0), T2 AS (SELECT SEAT_ID, COUNT(*) OVER (PARTITION BY DIFF) AS CNT FROM T1) SELECT SEAT_ID FROM T2 WHERE CNT >= 2 ORDER BY 1, SEAT_ID NULLS LAST;

/*
Prediction Result:
(5,)
(6,)
*/