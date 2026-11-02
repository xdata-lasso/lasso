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
WITH CTE1 AS (SELECT *, LAG(FREE) OVER () AS FREE_NEXT FROM CINEMA), CTE2 AS (SELECT *, CASE WHEN FREE <> FREE_NEXT THEN 1 ELSE 0 END AS IND FROM CTE1), CTE3 AS (SELECT *, SUM(IND) OVER (ORDER BY SEAT_ID) AS CAT FROM CTE2), CTE4 AS (SELECT SEAT_ID, FREE, COUNT(CAT) OVER (PARTITION BY CAT) AS CONT_NUM FROM CTE3) SELECT SEAT_ID FROM CTE4 WHERE CONT_NUM >= 2 AND FREE = '1' ORDER BY SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
(5,)
(7,)
(9,)
(10,)
*/