-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1139, NULL, 1141);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1139, 1142, NULL, 1141);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1139, 1143, NULL, 1145);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(None, 4568)
*/

-- Prediction Query
WITH T1 AS (SELECT A.*, B.APPLE_COUNT AS APPLE2, B.ORANGE_COUNT AS ORANGE2 FROM BOXES AS A LEFT JOIN CHESTS AS B ON A.CHEST_ID = B.CHEST_ID), T2 AS (SELECT BOX_ID, CHEST_ID, COALESCE(APPLE_COUNT, 0) + COALESCE(APPLE2, 0) AS APPLE, COALESCE(ORANGE_COUNT, 0) + COALESCE(ORANGE2, 0) AS ORANGE FROM T1) SELECT SUM(APPLE) AS APPLE_COUNT, SUM(ORANGE) AS ORANGE_COUNT FROM T2;

/*
Prediction Result:
(0, 4568)
*/