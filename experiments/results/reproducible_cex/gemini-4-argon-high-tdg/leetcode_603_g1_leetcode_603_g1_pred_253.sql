-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 1);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(3,)
(4,)
(6,)
(7,)
(8,)
*/

-- Prediction Query
SELECT T1.SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAG1, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAG2 FROM CINEMA) AS T1 WHERE (T1.LAG1 = 1 AND T1.FREE = 1) OR (T1.LAG2 = 1 AND T1.FREE = 1) ORDER BY T1.SEAT_ID;

/*
Prediction Result:
(1,)
(3,)
(4,)
(6,)
(7,)
(8,)
(10,)
*/