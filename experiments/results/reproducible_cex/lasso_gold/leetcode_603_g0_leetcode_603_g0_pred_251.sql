-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (11, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (110, -1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (111, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(10,)
(11,)
*/

-- Prediction Query
SELECT DISTINCT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE ABS(C2.SEAT_ID - C1.SEAT_ID) = 1 AND C1.FREE * C2.FREE = 1 ORDER BY C1.SEAT_ID;

/*
Prediction Result:
(10,)
(11,)
(110,)
(111,)
*/