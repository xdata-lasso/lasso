-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests UNION ALL vs UNION by ensuring the sum of boxes equals the sum of joined chests.
-- A mutant using UNION instead of UNION ALL will deduplicate the two identical rows before the outer SUM.
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 10, 20);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 100, 10, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(20, 40)
*/

-- Prediction Query
WITH A AS (SELECT B.*, C.APPLE_COUNT AS A, C.ORANGE_COUNT AS C FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID), T AS (SELECT SUM(COALESCE(APPLE_COUNT, 0)) AS AC, SUM(COALESCE(ORANGE_COUNT, 0)) AS OC FROM A UNION SELECT SUM(COALESCE(A, 0)), SUM(COALESCE(C, 0)) FROM A) SELECT SUM(AC) AS APPLE_COUNT, SUM(OC) AS ORANGE_COUNT FROM T;

/*
Prediction Result:
(10, 20)
*/