-- Schema DDL
CREATE TABLE "CINEMA" (
    "SEAT_ID" INT,
    "FREE" INT,
    PRIMARY KEY ("SEAT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CINEMA VALUES (-2, 1);
INSERT INTO CINEMA VALUES (0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT CASE WHEN T1.FREE = 1 AND ((SELECT FREE FROM CINEMA WHERE SEAT_ID = T1.SEAT_ID - 1 AND FREE = 1) OR ((SELECT FREE FROM CINEMA WHERE SEAT_ID = T1.SEAT_ID + 1 AND FREE = 1))) THEN T1.SEAT_ID ELSE NULL END AS C_SEATS FROM CINEMA AS T1) SELECT C_SEATS AS SEAT_ID FROM T WHERE NOT C_SEATS IS NULL;

/*
Prediction Result:
*/