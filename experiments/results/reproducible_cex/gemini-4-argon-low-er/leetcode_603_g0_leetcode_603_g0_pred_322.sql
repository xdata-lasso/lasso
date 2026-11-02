-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT C.SEAT_ID FROM (SELECT *, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAG1, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS LEAD1 FROM CINEMA) AS C WHERE (C.FREE = 1) AND ((C.FREE = C.LAG1) OR (C.FREE = C.LEAD1)) ORDER BY C.SEAT_ID;

/*
Prediction Result:
(1,)
(3,)
*/