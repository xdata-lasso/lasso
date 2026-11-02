-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests NULL values and non-binary integers in the 'free' column.
-- Specifically kills mutants using `free != 0`, `free > 0`, or `IS NOT NULL` instead of `free = 1`.
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, NULL);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 2);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, -1);
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
WITH SEAT AS (SELECT SEAT_ID, FREE, SUM(FREE) OVER (ORDER BY SEAT_ID) - SEAT_ID AS GAP FROM CINEMA) SELECT SEAT_ID FROM SEAT WHERE GAP IN (SELECT GAP FROM SEAT WHERE FREE = 1 GROUP BY GAP HAVING COUNT(*) > 1) AND FREE = 1 ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(5,)
(7,)
(8,)
*/