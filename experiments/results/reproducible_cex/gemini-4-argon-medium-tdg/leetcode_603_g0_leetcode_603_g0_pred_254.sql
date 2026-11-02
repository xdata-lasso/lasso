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
SELECT T1.SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAG1, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAG2 FROM CINEMA) AS T1 WHERE (T1.LAG1 = 1 AND T1.FREE = 1) OR (T1.LAG2 = 1 AND T1.FREE = 1) ORDER BY T1.SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(5,)
(7,)
(9,)
(10,)
*/