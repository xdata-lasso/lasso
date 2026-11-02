-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);
INSERT INTO "cinema" ("seat_id", "free") VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, CASE WHEN FREE = 1 AND (FREE = LEAD(FREE, 1) OVER (ORDER BY SEAT_ID ASC) OR FREE = LAG(FREE, 1) OVER (ORDER BY SEAT_ID ASC)) THEN 1 ELSE 0 END AS LAG_FREE FROM CINEMA) AS T WHERE LAG_FREE = 1;

/*
Prediction Result:
(1,)
(3,)
*/