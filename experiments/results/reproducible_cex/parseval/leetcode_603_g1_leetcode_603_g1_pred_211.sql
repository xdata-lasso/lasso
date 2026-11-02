-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, -55602865);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, -59984348);

INSERT INTO "cinema" ("seat_id", "free") VALUES (5, -55602865);

INSERT INTO "cinema" ("seat_id", "free") VALUES (6, -59984348);

INSERT INTO "cinema" ("seat_id", "free") VALUES (7, -664303813);

INSERT INTO "cinema" ("seat_id", "free") VALUES (8, -1022641847);

INSERT INTO "cinema" ("seat_id", "free") VALUES (9, -1726781632);

INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 247012447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A LEFT JOIN CINEMA AS B ON A.SEAT_ID - B.SEAT_ID = 1 LEFT JOIN CINEMA AS C ON C.SEAT_ID - A.SEAT_ID = 1 WHERE A.FREE = TRUE AND (B.FREE IS TRUE OR C.FREE IS TRUE) ORDER BY A.SEAT_ID ASC;

/*
Prediction Result:
(2,)
*/