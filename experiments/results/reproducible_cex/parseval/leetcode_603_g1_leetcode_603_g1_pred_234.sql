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
WITH TEMP AS (SELECT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.SEAT_ID + 1 = C2.SEAT_ID AND C1.FREE AND C2.FREE), TEMP1 AS (SELECT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.SEAT_ID - 1 = C2.SEAT_ID AND C1.FREE AND C2.FREE) SELECT * FROM (SELECT T1.SEAT_ID FROM TEMP AS T1 UNION SELECT T2.SEAT_ID FROM TEMP1 AS T2) AS F ORDER BY SEAT_ID;

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