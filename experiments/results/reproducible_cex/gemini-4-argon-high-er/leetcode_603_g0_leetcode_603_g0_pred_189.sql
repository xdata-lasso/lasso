-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS LAG_FREE, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS LEAD_FREE FROM CINEMA) AS A WHERE ((A.FREE - A.LAG_FREE) = 0 OR (A.FREE - A.LEAD_FREE) = 0) AND A.FREE = 1;

/*
Prediction Result:
(1,)
(3,)
*/