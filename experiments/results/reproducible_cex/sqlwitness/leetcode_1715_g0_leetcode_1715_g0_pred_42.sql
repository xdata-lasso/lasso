-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (NULL, 1, 1), (0, NULL, NULL), (1, 1, 0), (-1, 0, NULL), (2, NULL, 0), (3, NULL, NULL), (4, 1, 0);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (3, -1, NULL, 0), (0, NULL, 0, 1), (3, 1, 0, 0), (4, 0, NULL, 0), (-1, 2, 0, NULL), (-1, 3, NULL, 1), (4, 4, NULL, NULL), (1, 5, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(2, 2)
*/

-- Prediction Query
WITH CTE AS (SELECT BOX_ID, CASE WHEN B.CHEST_ID = C.CHEST_ID THEN B.APPLE_COUNT + C.APPLE_COUNT ELSE B.APPLE_COUNT END AS APPLE, CASE WHEN B.CHEST_ID = C.CHEST_ID THEN B.ORANGE_COUNT + C.ORANGE_COUNT ELSE B.ORANGE_COUNT END AS ORANGE FROM BOXES AS B LEFT JOIN CHESTS AS C USING (CHEST_ID)) SELECT SUM(APPLE) AS APPLE_COUNT, SUM(ORANGE) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(2, 0)
*/