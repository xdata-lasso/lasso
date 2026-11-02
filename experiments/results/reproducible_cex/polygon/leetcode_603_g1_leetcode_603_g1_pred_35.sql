-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, COUNT(*) OVER (PARTITION BY SEAT_ID - RN) AS CT FROM (SELECT SEAT_ID, FREE, ROW_NUMBER() OVER (ORDER BY SEAT_ID) AS RN FROM CINEMA WHERE FREE = 1) AS A) AS B WHERE CT >= 2;

/*
Prediction Result:
(1,)
(2,)
*/