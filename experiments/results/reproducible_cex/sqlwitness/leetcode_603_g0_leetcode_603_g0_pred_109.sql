-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 0), (0, 1), (1, 1), (3, 1), (4, 0), (5, 0), (6, 0), (7, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, LAG(FREE) OVER () AS LAG1, FREE, LEAD(FREE) OVER () AS LEAD1 FROM CINEMA AS C) AS SUB WHERE (SUB.LAG1 = 1 AND SUB.FREE = 1) OR (SUB.FREE = 1 AND SUB.LEAD1);

/*
Prediction Result:
(0,)
(1,)
*/