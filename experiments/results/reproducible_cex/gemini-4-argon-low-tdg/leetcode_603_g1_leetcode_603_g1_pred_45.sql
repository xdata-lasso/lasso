-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard consecutive free seats, missing DISTINCT (middle seat 4 has two neighbors), and isolated free seats (seat 1).
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS FREE_LEAD, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS FREE_LAG FROM CINEMA) AS CINEMA_1 WHERE (CINEMA_1.FREE = '1') AND (CINEMA_1.FREE_LEAD = '1' OR CINEMA_1.FREE_LAG = '1') ORDER BY SEAT_ID;

/*
Prediction Result:
*/