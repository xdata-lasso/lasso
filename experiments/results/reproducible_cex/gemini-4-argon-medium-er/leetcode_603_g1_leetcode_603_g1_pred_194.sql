-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT TEMP1.SEAT_ID FROM (SELECT A.SEAT_ID, (CASE WHEN B.SEAT_ID - A.SEAT_ID = 1 AND A.FREE = 1 AND B.FREE = 1 THEN TRUE WHEN B.SEAT_ID - A.SEAT_ID = -1 AND A.FREE = 1 AND B.FREE = 1 THEN TRUE END) AS CONSECTIVE FROM CINEMA AS A CROSS JOIN CINEMA AS B) AS TEMP1 WHERE CONSECTIVE = 'TRUE' ORDER BY TEMP1.SEAT_ID;

/*
Prediction Result:
*/