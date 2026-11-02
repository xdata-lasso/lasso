-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1160, 1161, 1162);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1166, 1167, 1168);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1160, NULL, 1164, 1165);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1160, NULL, 1161, 1162);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1166, NULL, 1170, 1171);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1166, NULL, 1167, 1168);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(9318, 9326)
*/

-- Prediction Query
WITH AA AS (SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES), BB AS (SELECT A.APPLE_COUNT * COUNT(B.BOX_ID) AS APPLE_COUNT, A.ORANGE_COUNT * COUNT(B.BOX_ID) AS ORANGE_COUNT FROM CHESTS AS A JOIN BOXES AS B ON A.CHEST_ID = B.CHEST_ID GROUP BY A.CHEST_ID) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT * FROM AA UNION ALL SELECT * FROM BB) AS CC;

/*
Prediction Result:
(4662, 4666)
*/