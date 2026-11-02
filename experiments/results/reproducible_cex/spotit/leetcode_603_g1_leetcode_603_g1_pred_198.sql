-- Schema DDL
CREATE TABLE "CINEMA" (
    "SEAT_ID" INT,
    "FREE" INT,
    PRIMARY KEY ("SEAT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CINEMA VALUES (0, 2);
INSERT INTO CINEMA VALUES (1, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C1.SEAT_ID FROM CINEMA AS C1 CROSS JOIN CINEMA AS C2 WHERE (C1.SEAT_ID = C2.SEAT_ID + 1 OR C1.SEAT_ID = C2.SEAT_ID - 1) AND C1.FREE AND C2.FREE ORDER BY C1.SEAT_ID;

/*
Prediction Result:
(0,)
(1,)
*/