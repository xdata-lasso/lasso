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
WITH PREV_NEXT_FREE AS (SELECT SEAT_ID, FREE, LAG(FREE, 1, FALSE) OVER (ORDER BY SEAT_ID) AS PREV_FREE, LEAD(FREE, 1, FALSE) OVER (ORDER BY SEAT_ID) AS NEXT_FREE FROM CINEMA) SELECT SEAT_ID FROM PREV_NEXT_FREE WHERE FREE AND (PREV_FREE OR NEXT_FREE);

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