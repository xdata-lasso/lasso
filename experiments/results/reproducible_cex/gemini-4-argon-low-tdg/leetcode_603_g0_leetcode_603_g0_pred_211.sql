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
WITH T AS (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXT_FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS PREV_FREE FROM CINEMA) SELECT SEAT_ID FROM T WHERE ((NEXT_FREE = 1 AND FREE = 1) OR (PREV_FREE = 1 AND FREE = 1)) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(3,)
(4,)
(6,)
*/