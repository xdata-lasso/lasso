-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests handling of NULL values inside apple_count and orange_count columns across both tables,
-- as well as 0 boundary values and NULL chest_id in Chests.
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, 10);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (2, 20, NULL);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (NULL, 100, 100);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, 5, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (2, 2, NULL, 15);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 3, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(25, 35)
*/

-- Prediction Query
SELECT SUM(CASE WHEN NOT TB1.CHEST_ID IS NULL THEN (TB1.APPLE_COUNT + TB2.APPLE_COUNT) ELSE TB1.APPLE_COUNT END) AS APPLE_COUNT, SUM(CASE WHEN NOT TB1.CHEST_ID IS NULL THEN (TB1.ORANGE_COUNT + TB2.ORANGE_COUNT) ELSE TB1.ORANGE_COUNT END) AS ORANGE_COUNT FROM BOXES AS TB1 LEFT JOIN CHESTS AS TB2 ON TB1.CHEST_ID = TB2.CHEST_ID;

/*
Prediction Result:
(None, 10)
*/