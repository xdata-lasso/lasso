-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (0, 1, 1), (1, 0, 0), (-1, 0, 0), (NULL, 0, 1), (2, NULL, 0), (3, NULL, 1), (4, NULL, 1), (5, 1, NULL), (6, 0, NULL), (7, 1, 1), (8, 1, 0), (9, 1, NULL), (10, 0, 0), (11, 0, 0), (12, NULL, NULL), (13, NULL, 0), (14, NULL, 1), (15, 0, NULL), (16, NULL, 0), (17, 1, NULL), (18, NULL, 1);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (8, -1, NULL, 1), (18, 1, NULL, 1), (0, 0, 1, 1), (15, NULL, 1, 1), (16, 2, 1, NULL), (8, 3, NULL, 0), (0, 4, 0, 0), (15, 5, NULL, 1), (11, 6, 0, NULL), (17, 7, 0, 1), (3, 8, 1, 1), (11, 9, 1, 1), (18, 10, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(9, 12)
*/

-- Prediction Query
WITH CTE AS (SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES UNION SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C JOIN BOXES AS B ON C.CHEST_ID = B.CHEST_ID WHERE NOT B.CHEST_ID IS NULL) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(11, 13)
*/