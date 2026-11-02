-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 0);
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT C1.SEAT_ID FROM CINEMA AS C1 JOIN CINEMA AS C2 ON C1.SEAT_ID = C2.SEAT_ID - 1 AND C1.FREE = C2.FREE WHERE C1.FREE = 1 UNION SELECT C2.SEAT_ID FROM CINEMA AS C1 JOIN CINEMA AS C2 ON C1.SEAT_ID = C2.SEAT_ID - 1 AND C1.FREE = C2.FREE WHERE C1.FREE = 1) AS HFHF ORDER BY SEAT_ID;

/*
Prediction Result:
*/