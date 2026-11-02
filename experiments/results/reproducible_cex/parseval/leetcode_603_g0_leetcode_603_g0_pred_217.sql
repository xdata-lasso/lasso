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

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483643, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, -55602865);
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
WITH T_LEAD_LAG AS (SELECT LEAD(C.FREE) OVER (ORDER BY C.SEAT_ID) AS LEAD_ID, LAG(C.FREE) OVER (ORDER BY C.SEAT_ID) AS LAG_ID, C.SEAT_ID, C.FREE FROM CINEMA AS C) SELECT CTE.SEAT_ID FROM T_LEAD_LAG AS CTE WHERE (CTE.LEAD_ID = 1 AND CTE.FREE = 1) OR (CTE.LAG_ID = 1 AND CTE.FREE = 1) ORDER BY CTE.SEAT_ID;

/*
Prediction Result:
(-2147483643,)
(-1,)
(0,)
(1,)
(2,)
(3,)
*/