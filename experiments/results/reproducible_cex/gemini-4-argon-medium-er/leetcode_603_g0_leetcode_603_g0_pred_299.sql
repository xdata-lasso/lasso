-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 2);
INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A CROSS JOIN CINEMA AS B CROSS JOIN CINEMA AS C WHERE A.FREE <> 0 AND B.FREE <> 0 AND (A.SEAT_ID - 1 = B.SEAT_ID OR A.SEAT_ID + 1 = B.SEAT_ID) ORDER BY A.SEAT_ID;

/*
Prediction Result:
(1,)
(2,)
*/