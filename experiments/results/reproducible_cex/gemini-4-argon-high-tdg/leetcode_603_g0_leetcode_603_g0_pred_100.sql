-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
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
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER () AS PREVSEAT, LEAD(FREE, 1) OVER () AS NEXTSEAT FROM CINEMA) AS A WHERE (FREE = 1) AND (PREVSEAT = 1 OR NEXTSEAT = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(3,)
(4,)
(6,)
*/