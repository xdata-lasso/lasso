-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests gaps in seat_id (non-contiguous IDs) and unordered insertion.
-- Specifically kills mutants using LEAD/LAG window functions without checking actual seat_id value differences, or queries assuming output is naturally ordered without ORDER BY.
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 1);
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 1);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(1,)
(2,)
(9,)
(10,)
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM CINEMA AS C1 INNER JOIN (SELECT SEAT_ID, SUM(FREE) OVER (ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS SUM_FREE_B, SUM(FREE) OVER (ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS SUM_FREE_F FROM CINEMA AS C2) AS C2 ON C1.SEAT_ID = C2.SEAT_ID WHERE C2.SUM_FREE_B >= 2 OR C2.SUM_FREE_F >= 2;

/*
Prediction Result:
(1,)
(2,)
(5,)
(7,)
(9,)
(10,)
*/