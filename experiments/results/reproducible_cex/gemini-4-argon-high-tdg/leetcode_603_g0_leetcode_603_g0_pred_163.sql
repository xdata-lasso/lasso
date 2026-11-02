-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO cinema (seat_id, free) VALUES (1, NULL);
INSERT INTO cinema (seat_id, free) VALUES (2, NULL);
INSERT INTO cinema (seat_id, free) VALUES (3, 2);
INSERT INTO cinema (seat_id, free) VALUES (4, 2);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 2);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
(7,)
(8,)
*/

-- Prediction Query
SELECT SEAT_ID FROM CINEMA AS C WHERE FREE AND (EXISTS(SELECT * FROM CINEMA WHERE SEAT_ID = C.SEAT_ID - 1 AND FREE) OR EXISTS(SELECT * FROM CINEMA WHERE SEAT_ID = C.SEAT_ID + 1 AND FREE));

/*
Prediction Result:
(3,)
(4,)
(5,)
(6,)
(7,)
(8,)
*/