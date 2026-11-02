-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (0, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-1, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, 1);

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
SELECT T1.SEAT_ID FROM (SELECT SEAT_ID, FREE, COALESCE(LAG(FREE) OVER (), 0) AS PREVIOUS_SEAT_FREE, COALESCE(LEAD(FREE) OVER (), 0) AS NEXT_SEAT_FREE FROM CINEMA) AS T1 WHERE T1.FREE = 1 AND (T1.PREVIOUS_SEAT_FREE = 1 OR T1.NEXT_SEAT_FREE) ORDER BY T1.SEAT_ID;

/*
Prediction Result:
(-2147483642,)
(-1,)
(0,)
(1,)
(2,)
(3,)
*/