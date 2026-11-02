-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (NULL, NULL, NULL), (-1, NULL, 0), (1, 1, NULL), (0, NULL, 0), (2, 0, 0), (3, 1, 0), (4, 1, NULL), (5, NULL, 0), (6, NULL, NULL), (7, NULL, 1);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (-1, NULL, 1, 0), (-1, 0, NULL, 0), (1, -1, NULL, NULL), (NULL, 1, 1, 1), (7, 2, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(2, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT APPLE_COUNT, ORANGE_COUNT FROM BOXES UNION ALL SELECT C.APPLE_COUNT, C.ORANGE_COUNT FROM BOXES AS B JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(3, 2)
*/