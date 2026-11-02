-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (0, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-1, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, -55602865);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483642, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(-1,)
(0,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
WITH BASE AS (SELECT SEAT_ID, FREE, LEAD(FREE) OVER (ORDER BY SEAT_ID) AS L1, LAG(FREE) OVER (ORDER BY SEAT_ID) AS L2 FROM CINEMA) SELECT C.SEAT_ID FROM CINEMA AS C INNER JOIN BASE AS B ON B.SEAT_ID = C.SEAT_ID WHERE (C.FREE <> 0 AND B.L1 = 1) OR (C.FREE <> 0 AND B.L2 = 1);

/*
Prediction Result:
(-2147483642,)
(-1,)
(0,)
(1,)
(2,)
(3,)
(4,)
*/