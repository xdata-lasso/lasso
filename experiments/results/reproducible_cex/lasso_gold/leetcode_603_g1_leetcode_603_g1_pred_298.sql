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
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A CROSS JOIN CINEMA AS B CROSS JOIN CINEMA AS C WHERE A.FREE <> 0 AND B.FREE <> 0 AND (A.SEAT_ID - 1 = B.SEAT_ID OR A.SEAT_ID + 1 = B.SEAT_ID) ORDER BY A.SEAT_ID;

/*
Prediction Result:
(10,)
(11,)
(1004,)
(1005,)
*/