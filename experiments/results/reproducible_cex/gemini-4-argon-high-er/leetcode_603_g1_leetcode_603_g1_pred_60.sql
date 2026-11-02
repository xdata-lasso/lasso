-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT a.seat_id FROM cinema AS a JOIN cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free = TRUE AND b.free = TRUE ORDER BY a.seat_id;

/*
Gold Result:
*/

-- Prediction Query
WITH PREV_NEXT_FREE AS (SELECT SEAT_ID, FREE, LAG(FREE, 1, FALSE) OVER (ORDER BY SEAT_ID) AS PREV_FREE, LEAD(FREE, 1, FALSE) OVER (ORDER BY SEAT_ID) AS NEXT_FREE FROM CINEMA) SELECT SEAT_ID FROM PREV_NEXT_FREE WHERE FREE AND (PREV_FREE OR NEXT_FREE);

/*
Prediction Result:
(1,)
(3,)
*/