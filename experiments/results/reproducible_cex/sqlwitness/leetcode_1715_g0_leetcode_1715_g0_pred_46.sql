-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (1, 1, 0), (NULL, NULL, 1);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, NULL, NULL, NULL), (NULL, -1, 1, NULL), (1, 1, 1, NULL), (NULL, 0, NULL, NULL), (1, 2, 0, 0), (NULL, 3, NULL, 0), (NULL, 4, 0, 0), (NULL, 5, 1, 1), (NULL, 6, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(5, 2)
*/

-- Prediction Query
WITH TABLE1 AS (SELECT APPLE_COUNT, ORANGE_COUNT FROM BOXES UNION ALL SELECT C.APPLE_COUNT, C.ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B USING (CHEST_ID)) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM TABLE1;

/*
Prediction Result:
(6, 2)
*/