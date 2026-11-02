-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (2, NULL);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT A.SEAT_ID FROM CINEMA AS A JOIN CINEMA AS B ON A.SEAT_ID = B.SEAT_ID - 1 WHERE A.FREE = 1 AND B.FREE = 1 UNION SELECT B.SEAT_ID FROM CINEMA AS A JOIN CINEMA AS B ON A.SEAT_ID = B.SEAT_ID - 1 WHERE A.FREE = 1 AND B.FREE = 1) AS C ORDER BY C.SEAT_ID;

/*
Prediction Result:
*/