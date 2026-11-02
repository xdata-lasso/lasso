-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 2);
INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT CINEMA.SEAT_ID FROM CINEMA LEFT JOIN CINEMA AS PREVIOUS ON CINEMA.SEAT_ID - PREVIOUS.SEAT_ID = 1 LEFT JOIN CINEMA AS SUCCESSIVE ON SUCCESSIVE.SEAT_ID - CINEMA.SEAT_ID = 1 WHERE CINEMA.FREE AND (PREVIOUS.FREE OR SUCCESSIVE.FREE) ORDER BY 1, CINEMA.seat_id NULLS LAST, PREVIOUS.seat_id NULLS LAST, SUCCESSIVE.seat_id NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
*/