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
WITH TEMP AS (SELECT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.SEAT_ID + 1 = C2.SEAT_ID AND C1.FREE AND C2.FREE), TEMP1 AS (SELECT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.SEAT_ID - 1 = C2.SEAT_ID AND C1.FREE AND C2.FREE) SELECT * FROM (SELECT T1.SEAT_ID FROM TEMP AS T1 UNION SELECT T2.SEAT_ID FROM TEMP1 AS T2) AS F ORDER BY SEAT_ID;

/*
Prediction Result:
(3,)
(4,)
(5,)
(6,)
(7,)
(8,)
*/