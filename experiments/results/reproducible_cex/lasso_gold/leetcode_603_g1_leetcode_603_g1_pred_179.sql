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
WITH T AS (SELECT SEAT_ID, LEAD(FREE, 1, 0) OVER (ORDER BY SEAT_ID ASC) AS LEAD_FREE, LAG(FREE, 1, 0) OVER (ORDER BY SEAT_ID ASC) AS LAG_FREE, FREE FROM CINEMA) SELECT DISTINCT SEAT_ID FROM T WHERE T.FREE = 1 AND (T.LEAD_FREE = 1 OR T.LAG_FREE = 1) ORDER BY 1 ASC, SEAT_ID NULLS LAST;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/