-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, NULL, 12);
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (2, 15, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 101, 7, 8);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (2, 102, 9, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(31, 31)
*/

-- Prediction Query
WITH CTE1 AS (SELECT B.BOX_ID, B.CHEST_ID, CASE WHEN NOT B.CHEST_ID IS NULL THEN B.APPLE_COUNT + C.APPLE_COUNT END AS APPLE_COUNT, CASE WHEN NOT B.CHEST_ID IS NULL THEN B.ORANGE_COUNT + C.ORANGE_COUNT END AS ORANGE_COUNT FROM BOXES AS B JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID UNION ALL SELECT BOX_ID, CHEST_ID, APPLE_COUNT, ORANGE_COUNT FROM BOXES WHERE CHEST_ID IS NULL) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM CTE1;

/*
Prediction Result:
(24, 20)
*/