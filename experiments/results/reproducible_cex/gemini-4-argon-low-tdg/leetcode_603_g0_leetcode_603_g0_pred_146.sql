-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(3,)
(4,)
*/

-- Prediction Query
WITH TMP AS (SELECT SEAT_ID, FREE, CASE WHEN (FREE = 1 AND LAG(FREE) OVER (ORDER BY SEAT_ID) = 1) OR (FREE = 1 AND LEAD(FREE) OVER (ORDER BY SEAT_ID) = 1) THEN 1 ELSE 0 END AS CC FROM CINEMA) SELECT SEAT_ID FROM TMP WHERE CC = 1;

/*
Prediction Result:
(1,)
(3,)
(4,)
(6,)
*/