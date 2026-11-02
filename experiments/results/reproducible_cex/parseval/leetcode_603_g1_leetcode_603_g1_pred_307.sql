-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, -55602865);

INSERT INTO "cinema" ("seat_id", "free") VALUES (2, -59984348);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, -664303813);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483645, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, -1022641847);

INSERT INTO "cinema" ("seat_id", "free") VALUES (5, -1726781632);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483642, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (6, 247012447);

INSERT INTO "cinema" ("seat_id", "free") VALUES (7, -1980249628);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483639, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
WITH INCLUDE_SURROUNDING_SEATS AS (SELECT C.SEAT_ID, C.FREE, LEAD(C.FREE, 1) OVER () AS NEXT_SEAT, LAG(C.FREE, 1) OVER () AS PREV_SEAT FROM CINEMA AS C) SELECT SS.SEAT_ID FROM INCLUDE_SURROUNDING_SEATS AS SS WHERE SS.FREE = 1 AND (SS.NEXT_SEAT = 1 OR SS.PREV_SEAT = 1) ORDER BY SS.SEAT_ID ASC;

/*
Prediction Result:
(-2147483645,)
(-2147483642,)
(-2147483639,)
*/