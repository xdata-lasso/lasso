-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, -55602865);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483647, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (2, -59984348);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, -664303813);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483644, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, -1022641847);

INSERT INTO "cinema" ("seat_id", "free") VALUES (5, -1726781632);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483641, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (6, 247012447);

INSERT INTO "cinema" ("seat_id", "free") VALUES (7, -1980249628);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
WITH LEAD_LAG_SEAT AS (SELECT SEAT_ID, FREE, LEAD(FREE, 1, 0) OVER (ORDER BY SEAT_ID) AS LEAD_SEAT, LAG(FREE, 1, 0) OVER (ORDER BY SEAT_ID) AS LAG_SEAT FROM CINEMA) SELECT SEAT_ID FROM LEAD_LAG_SEAT WHERE (FREE = 1 AND LEAD_SEAT = 1) OR (FREE = 1 AND LAG_SEAT = 1) ORDER BY 1, SEAT_ID NULLS LAST;

/*
Prediction Result:
(-2147483647,)
(-2147483644,)
(-2147483641,)
*/