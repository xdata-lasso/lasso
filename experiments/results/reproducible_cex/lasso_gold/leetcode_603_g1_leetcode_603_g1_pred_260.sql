-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (-10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1002, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (11, 1);
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
SELECT A.SEAT_ID FROM (SELECT SEAT_ID, LAG(FREE) OVER (ORDER BY SEAT_ID) AS LAG1, LEAD(FREE) OVER (ORDER BY SEAT_ID) AS LEAD1, FREE FROM CINEMA) AS A WHERE (A.FREE = 1 AND A.LAG1 = 1) OR (A.FREE = 1 AND A.LEAD1 = 1) ORDER BY A.SEAT_ID;

/*
Prediction Result:
(-10,)
(10,)
(11,)
(1002,)
*/