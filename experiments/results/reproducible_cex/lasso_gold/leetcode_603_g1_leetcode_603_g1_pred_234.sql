-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (10, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (11, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1004, 2);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1005, 2);
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
WITH TEMP AS (SELECT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.SEAT_ID + 1 = C2.SEAT_ID AND C1.FREE AND C2.FREE), TEMP1 AS (SELECT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.SEAT_ID - 1 = C2.SEAT_ID AND C1.FREE AND C2.FREE) SELECT * FROM (SELECT T1.SEAT_ID FROM TEMP AS T1 UNION SELECT T2.SEAT_ID FROM TEMP1 AS T2) AS F ORDER BY SEAT_ID;

/*
Prediction Result:
(10,)
(11,)
(1004,)
(1005,)
*/