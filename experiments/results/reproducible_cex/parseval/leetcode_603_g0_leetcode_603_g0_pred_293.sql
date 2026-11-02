-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (0, -2435);

INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 2437);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2, 2437);

INSERT INTO "cinema" ("seat_id", "free") VALUES (2, -55602865);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, -59984348);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, -664303813);

INSERT INTO "cinema" ("seat_id", "free") VALUES (5, -1022641847);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.SEAT_ID FROM CINEMA AS A CROSS JOIN CINEMA AS B WHERE ABS(A.SEAT_ID - B.SEAT_ID) = 1 AND A.FREE + B.FREE = 2 ORDER BY A.SEAT_ID ASC;

/*
Prediction Result:
(0,)
(1,)
*/