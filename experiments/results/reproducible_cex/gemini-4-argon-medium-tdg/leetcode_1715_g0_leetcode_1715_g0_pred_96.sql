-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, 5);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (2, 7, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, 2, 3);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (2, 2, 11, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(20, 21)
*/

-- Prediction Query
WITH CNT AS (SELECT BOX_ID, B.CHEST_ID, (B.APPLE_COUNT + C.APPLE_COUNT) AS TOTAL_APPLE_CNT, (B.ORANGE_COUNT + C.ORANGE_COUNT) AS TOTAL_ORANGE_CNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID) SELECT SUM(CASE WHEN C.CHEST_ID IS NULL THEN APPLE_COUNT ELSE TOTAL_APPLE_CNT END) AS APPLE_COUNT, SUM(CASE WHEN C.CHEST_ID IS NULL THEN ORANGE_COUNT ELSE TOTAL_ORANGE_CNT END) AS ORANGE_COUNT FROM CNT AS C JOIN BOXES AS B ON C.BOX_ID = B.BOX_ID;

/*
Prediction Result:
(18, 8)
*/