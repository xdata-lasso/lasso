-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (-10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1002, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (11, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(10,)
(11,)
*/

-- Prediction Query
WITH ALL_DATA AS (SELECT CASE WHEN (FREE = 1 AND LAG(FREE) OVER (ORDER BY SEAT_ID) = 1) OR (FREE = 1 AND LEAD(FREE) OVER (ORDER BY SEAT_ID) = 1) THEN SEAT_ID ELSE NULL END AS SEAT_ID FROM CINEMA) SELECT SEAT_ID FROM ALL_DATA WHERE NOT SEAT_ID IS NULL;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/