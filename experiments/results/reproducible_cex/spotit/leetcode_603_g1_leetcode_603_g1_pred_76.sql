-- Schema DDL
CREATE TABLE "CINEMA" (
    "SEAT_ID" INT,
    "FREE" INT,
    PRIMARY KEY ("SEAT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CINEMA VALUES (-1, -1);
INSERT INTO CINEMA VALUES (0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A JOIN CINEMA AS B ON ((A.SEAT_ID - B.SEAT_ID) = 1 OR (B.SEAT_ID - A.SEAT_ID) = 1) AND A.FREE AND B.FREE ORDER BY A.SEAT_ID;

/*
Prediction Result:
(-1,)
(0,)
*/