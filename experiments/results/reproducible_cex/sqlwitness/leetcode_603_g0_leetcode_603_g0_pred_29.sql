-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1), (0, 1), (2, 1), (3, 1), (4, 0), (5, 0), (6, 0), (7, 1), (8, 0), (9, 0), (10, 1), (11, 0), (12, 1), (13, 1);
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
(12,)
(13,)
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A JOIN CINEMA AS B ON ABS(A.SEAT_ID - B.SEAT_ID) = 1 AND A.FREE = TRUE AND B.FREE = TRUE ORDER BY 1, A.SEAT_ID NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
(2,)
(3,)
(12,)
(13,)
*/