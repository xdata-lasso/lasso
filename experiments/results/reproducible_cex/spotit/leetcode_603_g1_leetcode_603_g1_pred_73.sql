-- Schema DDL
CREATE TABLE "CINEMA" (
    "SEAT_ID" INT,
    "FREE" INT,
    PRIMARY KEY ("SEAT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CINEMA VALUES (-1, 1);
INSERT INTO CINEMA VALUES (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE C1.FREE = '1' AND C2.FREE = '1' AND ((C2.SEAT_ID = C1.SEAT_ID - 1) OR (C2.SEAT_ID = C1.SEAT_ID + 1)) GROUP BY C1.SEAT_ID;

/*
Prediction Result:
(-1,)
(0,)
*/