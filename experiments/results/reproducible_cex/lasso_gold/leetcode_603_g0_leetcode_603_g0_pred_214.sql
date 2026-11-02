-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (0, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1046, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (-1, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1048, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS PREVIOUS_SEAT, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS NEXT_SEAT FROM CINEMA) AS A WHERE (FREE = 1 AND NEXT_SEAT = 1) OR (FREE = 1 AND PREVIOUS_SEAT = 1) ORDER BY SEAT_ID;

/*
Prediction Result:
(-1,)
(0,)
(1046,)
(1048,)
*/