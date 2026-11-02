-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (11, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1004, 2);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1005, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(10,)
(11,)
*/

-- Prediction Query
WITH TMP AS (SELECT * FROM CINEMA WHERE FREE <> 0) SELECT DISTINCT A.SEAT_ID FROM TMP AS A JOIN TMP AS B ON ABS(A.SEAT_ID - B.SEAT_ID) = 1 ORDER BY 1, A.SEAT_ID NULLS LAST;

/*
Prediction Result:
(10,)
(11,)
(1004,)
(1005,)
*/