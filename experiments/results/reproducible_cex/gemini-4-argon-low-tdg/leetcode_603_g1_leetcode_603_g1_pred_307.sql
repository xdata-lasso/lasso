-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests strictness of `free = TRUE` (which is `free = 1` in SQLite) against NULL, 0, and truthy non-1 integers like 2 or -1.
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 2);
INSERT INTO cinema (seat_id, free) VALUES (3, -1);
INSERT INTO cinema (seat_id, free) VALUES (4, NULL);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT *, SEAT_ID - ROW_NUMBER() OVER (ORDER BY SEAT_ID) AS RN FROM CINEMA WHERE FREE > 0), CTE2 AS (SELECT *, COUNT(*) OVER (PARTITION BY RN) AS C FROM CTE) SELECT SEAT_ID FROM CTE2 WHERE C >= 2;

/*
Prediction Result:
(1,)
(2,)
*/