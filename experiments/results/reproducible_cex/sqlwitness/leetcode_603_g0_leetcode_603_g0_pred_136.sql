-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (-1, 1), (1, 1), (0, 1), (2, 1), (3, 1), (4, 0), (5, 1), (6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(-1,)
(0,)
(1,)
(2,)
(3,)
(5,)
(6,)
*/

-- Prediction Query
WITH TMP AS (SELECT * FROM CINEMA WHERE FREE <> 0) SELECT DISTINCT A.SEAT_ID FROM TMP AS A JOIN TMP AS B ON ABS(A.SEAT_ID - B.SEAT_ID) = 1 ORDER BY 1, A.SEAT_ID NULLS LAST;

/*
Prediction Result:
(-1,)
(0,)
(1,)
(2,)
(3,)
(5,)
(6,)
*/