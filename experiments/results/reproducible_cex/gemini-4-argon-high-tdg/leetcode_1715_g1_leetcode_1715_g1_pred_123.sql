-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 9
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, 20);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(10, 20)
*/

-- Prediction Query
SELECT IIF((AC1 + AC2) IS NULL, AC2, (AC1 + AC2)) AS APPLE_COUNT, IIF((OC1 + OC2) IS NULL, OC2, (OC1 + OC2)) AS ORANGE_COUNT FROM (SELECT SUM(C.APPLE_COUNT) AS AC1, SUM(C.ORANGE_COUNT) AS OC1, SUM(B.APPLE_COUNT) AS AC2, SUM(B.ORANGE_COUNT) AS OC2 FROM BOXES AS B LEFT JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID) AS T;

/*
Prediction Result:
(10, None)
*/