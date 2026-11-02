-- Schema DDL
CREATE TABLE "cinema" ("seat_id" INTEGER PRIMARY KEY, "free" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cinema --
INSERT INTO "cinema" ("seat_id", "free") VALUES (1, 2);

INSERT INTO "cinema" ("seat_id", "free") VALUES (2, 2);

INSERT INTO "cinema" ("seat_id", "free") VALUES (4, NULL);

INSERT INTO "cinema" ("seat_id", "free") VALUES (3, 2);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483644, 2);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483643, NULL);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483642, 2);

INSERT INTO "cinema" ("seat_id", "free") VALUES (5, 2);

INSERT INTO "cinema" ("seat_id", "free") VALUES (7, NULL);

INSERT INTO "cinema" ("seat_id", "free") VALUES (6, 2);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483638, 2);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483637, NULL);

INSERT INTO "cinema" ("seat_id", "free") VALUES (-2147483636, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT O1.SEAT_ID FROM CINEMA AS O1 WHERE O1.FREE = 1 AND ((SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID - 1) = 1 OR (SELECT FREE FROM CINEMA AS O2 WHERE O2.SEAT_ID = O1.SEAT_ID + 1) = 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT C1.SEAT_ID FROM CINEMA AS C1 LEFT JOIN CINEMA AS C2 ON C1.SEAT_ID + 1 = C2.SEAT_ID LEFT JOIN CINEMA AS C3 ON C1.SEAT_ID = C3.SEAT_ID + 1 WHERE (C1.FREE <> 0) AND (C1.FREE = C2.FREE OR C1.FREE = C3.FREE);

/*
Prediction Result:
(1,)
(2,)
(3,)
(5,)
(6,)
*/