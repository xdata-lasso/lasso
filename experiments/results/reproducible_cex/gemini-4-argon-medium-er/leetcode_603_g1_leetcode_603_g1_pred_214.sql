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
SELECT SEAT_ID FROM (SELECT FREE, SEAT_ID, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAG_SEAT, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS LEAD_SEAT FROM CINEMA) AS T WHERE (FREE + COALESCE(LAG_SEAT, 0) + COALESCE(LEAD_SEAT, 0)) >= 2 AND FREE > 0;

/*
Prediction Result:
(1,)
(3,)
*/