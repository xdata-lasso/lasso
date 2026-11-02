-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard consecutive sequences (pair and triplet), isolated free seats, and occupied seats surrounded by free seats.
-- Specifically kills mutants missing DISTINCT (via seat 4), missing O1.FREE = 1 (via seat 2), or using AND instead of OR for neighbors.
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(3,)
(4,)
(5,)
(7,)
(8,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS FREE_LEAD, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS FREE_LAG FROM CINEMA) AS CINEMA_1 WHERE (CINEMA_1.FREE = '1') AND (CINEMA_1.FREE_LEAD = '1' OR CINEMA_1.FREE_LAG = '1') ORDER BY SEAT_ID;

/*
Prediction Result:
*/