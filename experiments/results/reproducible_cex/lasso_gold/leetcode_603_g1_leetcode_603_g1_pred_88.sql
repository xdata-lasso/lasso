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
SELECT DISTINCT SEAT_ID FROM (SELECT DISTINCT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXT_FREE_IND, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS PRE_FREE_IND FROM CINEMA) AS A WHERE FREE = 1 AND (NEXT_FREE_IND = 1 OR PRE_FREE_IND = 1) ORDER BY 1, SEAT_ID NULLS LAST;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/