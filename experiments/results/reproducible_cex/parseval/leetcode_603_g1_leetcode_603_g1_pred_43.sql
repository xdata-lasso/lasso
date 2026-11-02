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
SELECT X.SEAT_ID FROM (SELECT C.SEAT_ID, C.FREE, LAG(C.FREE, 1) OVER (ORDER BY C.SEAT_ID) AS LAG_FREE, LEAD(C.FREE, 1) OVER (ORDER BY C.SEAT_ID) AS LEAD_FREE FROM CINEMA AS C) AS X WHERE (X.FREE = 1 AND X.LAG_FREE = 1) OR (X.FREE = 1 AND X.LEAD_FREE = 1) ORDER BY 1, X.SEAT_ID NULLS LAST;

/*
Prediction Result:
(-2147483645,)
(-2147483642,)
(-2147483639,)
*/