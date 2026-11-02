-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1076, 1077, 1078);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1083, 1084, 1085);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1076, 1079, 1077, 1078);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1076, 1080, 1081, 1082);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1083, 1086, NULL, 1085);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1083, 1087, NULL, 1089);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(6480, 8660)
*/

-- Prediction Query
WITH CTE AS (SELECT BOX_ID, T1.CHEST_ID, T1.APPLE_COUNT AS A1, T2.APPLE_COUNT AS A2, T1.ORANGE_COUNT AS O1, T2.ORANGE_COUNT AS O2 FROM BOXES AS T1 LEFT JOIN CHESTS AS T2 ON T1.CHEST_ID = T2.CHEST_ID), CTE2 AS (SELECT BOX_ID, CASE WHEN CHEST_ID IS NULL THEN A1 ELSE A1 + A2 END AS TOTAL_APPLE_CNT, CASE WHEN CHEST_ID IS NULL THEN O1 ELSE O1 + O2 END AS ORANGE_CNT FROM CTE) SELECT SUM(TOTAL_APPLE_CNT) AS APPLE_COUNT, SUM(ORANGE_CNT) AS ORANGE_COUNT FROM CTE2;

/*
Prediction Result:
(4312, 8660)
*/