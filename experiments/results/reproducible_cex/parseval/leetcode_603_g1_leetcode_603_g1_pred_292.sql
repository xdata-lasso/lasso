-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (-1, -2435);

INSERT INTO "cinema" ("seat_id", "free") VALUES (0, 2437);

INSERT INTO "cinema" ("seat_id", "free") VALUES (1, -6415);

INSERT INTO "cinema" ("seat_id", "free") VALUES (2, -55602865);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, -59984348);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, -664303813);

INSERT INTO "cinema" ("seat_id", "free") VALUES (5, -1022641847);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A CROSS JOIN CINEMA AS B WHERE ABS(A.SEAT_ID - B.SEAT_ID) = 1 AND A.FREE + B.FREE = 2 ORDER BY A.SEAT_ID ASC;

/*
Prediction Result:
(-1,)
(0,)
*/