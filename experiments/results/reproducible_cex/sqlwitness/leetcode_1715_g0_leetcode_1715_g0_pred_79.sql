-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (NULL, 1, NULL), (0, NULL, 1), (-1, 1, NULL), (1, 1, NULL), (2, 0, NULL), (3, 0, 1), (4, NULL, 1), (5, 1, 1);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (1, -1, NULL, 1), (2, NULL, 1, 1), (NULL, 0, NULL, 0), (5, 1, 1, NULL), (3, 2, 1, 1), (3, 3, 0, 1), (-1, 4, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(4, 7)
*/

-- Prediction Query
SELECT SUM(CASE WHEN A.CHEST_ID IS NULL THEN A.APPLE_COUNT ELSE A.APPLE_COUNT + B.APPLE_COUNT END) AS APPLE_COUNT, SUM(CASE WHEN A.CHEST_ID IS NULL THEN A.ORANGE_COUNT ELSE A.ORANGE_COUNT + B.ORANGE_COUNT END) AS ORANGE_COUNT FROM BOXES AS A LEFT JOIN CHESTS AS B ON A.CHEST_ID = B.CHEST_ID;

/*
Prediction Result:
(4, 4)
*/