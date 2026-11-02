-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (0, -1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (1, -1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2, -1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-1, 1);

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
SELECT DISTINCT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE ABS(C2.SEAT_ID - C1.SEAT_ID) = 1 AND C1.FREE * C2.FREE = 1 ORDER BY C1.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
*/