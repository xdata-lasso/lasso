-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Chests (chest_id, apple_count, orange_count) VALUES (1, 10, 20);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 1, NULL, 5);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, 2, 6, NULL);
INSERT INTO Boxes (chest_id, box_id, apple_count, orange_count) VALUES (NULL, 3, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(18, 28)
*/

-- Prediction Query
WITH CTE AS (SELECT SUM(A.APPLE_COUNT) AS BOX_APPLE, SUM(A.ORANGE_COUNT) AS BOX_ORANGE, SUM(CASE WHEN NOT A.CHEST_ID IS NULL THEN B.APPLE_COUNT ELSE 0 END) AS CHEST_APPLE, SUM(CASE WHEN NOT A.CHEST_ID IS NULL THEN B.ORANGE_COUNT ELSE 0 END) AS CHEST_ORANGE FROM BOXES AS A LEFT JOIN CHESTS AS B ON A.CHEST_ID = B.CHEST_ID) SELECT SUM(APPLE) AS APPLE_COUNT, SUM(ORANGE) AS ORANGE_COUNT FROM (SELECT BOX_APPLE AS APPLE, BOX_ORANGE AS ORANGE FROM CTE UNION SELECT CHEST_APPLE AS APPLE, CHEST_ORANGE AS ORANGE FROM CTE) AS A;

/*
Prediction Result:
(28, 48)
*/