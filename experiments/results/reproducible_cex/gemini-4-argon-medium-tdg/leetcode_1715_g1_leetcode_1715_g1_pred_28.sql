-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. UNION vs UNION ALL (Branch 1 and Branch 2 evaluate to identical sums: 10, 20).
-- 2. Unreferenced Chests (chest_id = 2 has no boxes, testing if Chests is summed directly without JOIN).
-- 3. Box with NULL chest_id (box_id = 102 is included in Boxes sum, excluded from Join sum).
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (1, 10, 20);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (2, 100, 200);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 101, 6, 12);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, 102, 4, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(20, 40)
*/

-- Prediction Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES UNION SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS X LEFT JOIN CHESTS AS C ON X.CHEST_ID = C.CHEST_ID WHERE NOT X.CHEST_ID IS NULL) AS X1;

/*
Prediction Result:
(10, 20)
*/