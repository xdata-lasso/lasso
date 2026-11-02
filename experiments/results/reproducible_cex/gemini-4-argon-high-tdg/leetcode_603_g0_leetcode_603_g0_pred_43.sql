-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(3,)
(4,)
*/

-- Prediction Query
SELECT X.SEAT_ID FROM (SELECT C.SEAT_ID, C.FREE, LAG(C.FREE, 1) OVER (ORDER BY C.SEAT_ID) AS LAG_FREE, LEAD(C.FREE, 1) OVER (ORDER BY C.SEAT_ID) AS LEAD_FREE FROM CINEMA AS C) AS X WHERE (X.FREE = 1 AND X.LAG_FREE = 1) OR (X.FREE = 1 AND X.LEAD_FREE = 1) ORDER BY 1, X.SEAT_ID NULLS LAST;

/*
Prediction Result:
(1,)
(3,)
(4,)
(6,)
*/