-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (0, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
WITH RANKED_SEATS AS (SELECT CI.SEAT_ID, ROW_NUMBER() OVER (ORDER BY SEAT_ID) AS RNK FROM CINEMA AS CI WHERE CI.FREE = 1), CATEGORIZED_SEATS AS (SELECT SEAT_ID, RNK, SEAT_ID - RNK AS GRP FROM RANKED_SEATS) SELECT DISTINCT SEAT_ID FROM CATEGORIZED_SEATS WHERE GRP IN (SELECT GRP FROM CATEGORIZED_SEATS GROUP BY GRP HAVING COUNT(1) > 1);

/*
Prediction Result:
(0,)
(1,)
*/