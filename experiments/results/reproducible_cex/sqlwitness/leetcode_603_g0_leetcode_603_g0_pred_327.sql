-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (2, 1), (1, 1), (0, 1), (3, 1), (4, 1), (5, 0), (6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
(4,)
*/

-- Prediction Query
SELECT SEAT_ID FROM (SELECT SEAT_ID, FREE, LAG(FREE, 1) OVER (ORDER BY SEAT_ID) AS P_SEAT, LEAD(FREE, 1) OVER (ORDER BY SEAT_ID) AS F_SEAT FROM CINEMA) AS A WHERE A.FREE = 1 AND A.P_SEAT = 1 OR A.FREE = 1 AND A.F_SEAT = 1 ORDER BY A.SEAT_ID, SEAT_ID NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(4,)
*/