-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (-1, 0, 0), (0, 1, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (0, 1, 1, 1), (NULL, -1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(3, 2)
*/

-- Prediction Query
SELECT SUM(IIF(NOT B.CHEST_ID IS NULL, B.APPLE_COUNT + C.APPLE_COUNT, B.APPLE_COUNT)) AS APPLE_COUNT, SUM(IIF(NOT B.CHEST_ID IS NULL, B.ORANGE_COUNT + C.ORANGE_COUNT, B.ORANGE_COUNT)) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID;

/*
Prediction Result:
(3, 1)
*/