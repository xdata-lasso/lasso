-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (0, 1), (2, 0), (1, 1), (3, 1), (4, 1), (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(0,)
(1,)
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, LAG(FREE) OVER () AS LAG1, FREE, LEAD(FREE) OVER () AS LEAD1 FROM CINEMA AS C) AS SUB WHERE (SUB.LAG1 = 1 AND SUB.FREE = 1) OR (SUB.FREE = 1 AND SUB.LEAD1);

/*
Prediction Result:
(0,)
(1,)
(3,)
(4,)
(5,)
*/