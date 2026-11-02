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
SELECT CINEMA.SEAT_ID FROM CINEMA LEFT JOIN CINEMA AS PREVIOUS ON CINEMA.SEAT_ID - PREVIOUS.SEAT_ID = 1 LEFT JOIN CINEMA AS SUCCESSIVE ON SUCCESSIVE.SEAT_ID - CINEMA.SEAT_ID = 1 WHERE CINEMA.FREE AND (PREVIOUS.FREE OR SUCCESSIVE.FREE) ORDER BY 1, CINEMA.seat_id NULLS LAST, PREVIOUS.seat_id NULLS LAST, SUCCESSIVE.seat_id NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(5,)
(6,)
(7,)
*/