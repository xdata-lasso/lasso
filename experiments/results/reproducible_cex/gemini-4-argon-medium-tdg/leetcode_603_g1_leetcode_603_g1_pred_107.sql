-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 0);
INSERT INTO cinema (seat_id, free) VALUES (6, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 1);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
(8,)
(9,)
(10,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT *, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS LA, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS LEA FROM CINEMA) AS T WHERE (FREE = 1 AND LA = 1) OR (FREE = 1 AND LEA = 1) ORDER BY 1, SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
(4,)
(6,)
(8,)
(9,)
(10,)
*/