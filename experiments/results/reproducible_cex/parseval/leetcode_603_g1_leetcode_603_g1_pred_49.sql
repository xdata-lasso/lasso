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
WITH "2_FREE" AS (SELECT SEAT_ID, FREE AS C_FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID ASC) AS CF_FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID ASC) AS CB_FREE FROM CINEMA ORDER BY SEAT_ID) SELECT SEAT_ID FROM "2_FREE" WHERE (C_FREE = 1 AND CF_FREE = 1) OR (C_FREE = 1 AND CB_FREE = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(-2147483647,)
(-2147483644,)
(-2147483641,)
*/