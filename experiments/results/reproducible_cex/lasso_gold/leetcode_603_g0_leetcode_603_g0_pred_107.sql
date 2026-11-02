-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (1075, 2);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1076, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1077, 5);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1078, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM CINEMA WHERE FREE = 1 AND (SEAT_ID + 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE = 1) OR SEAT_ID - 1 IN (SELECT SEAT_ID FROM CINEMA WHERE FREE - 0)) ORDER BY SEAT_ID;

/*
Prediction Result:
(1076,)
(1078,)
*/