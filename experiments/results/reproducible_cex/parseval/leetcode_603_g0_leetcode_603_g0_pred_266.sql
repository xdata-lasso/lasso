-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (0, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-1, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483643, 1);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, -55602865);
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
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A CROSS JOIN CINEMA AS B WHERE A.FREE AND (ABS(A.SEAT_ID - B.SEAT_ID) = 1 AND B.FREE) ORDER BY A.SEAT_ID;

/*
Prediction Result:
(-1,)
(0,)
(1,)
(2,)
(3,)
(4,)
*/