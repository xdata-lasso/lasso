-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests:
-- 1. Handling of NULLs in apple_count and orange_count, alongside 0 values.
-- 2. Catches mutants using '+' across columns/tables without COALESCE (e.g., B.apple_count + C.apple_count becomes NULL if one side is NULL, whereas separate SUMs ignore NULLs).
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (1, NULL, 5);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (2, 10, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 101, 8, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, 102, NULL, 12);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, 103, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(28, 17)
*/

-- Prediction Query
SELECT SUM(BOX_APPLE_CNT + CHEST_APPLE_CNT) AS APPLE_COUNT, SUM(BOX_ORANGE_CNT + CHEST_ORANGE_CNT) AS ORANGE_COUNT FROM (SELECT T1.APPLE_COUNT AS BOX_APPLE_CNT, COALESCE(T2.APPLE_COUNT, 0) AS CHEST_APPLE_CNT, T1.ORANGE_COUNT AS BOX_ORANGE_CNT, COALESCE(T2.ORANGE_COUNT, 0) AS CHEST_ORANGE_CNT FROM BOXES AS T1 LEFT JOIN CHESTS AS T2 ON T1.CHEST_ID = T2.CHEST_ID) AS T;

/*
Prediction Result:
(18, 12)
*/