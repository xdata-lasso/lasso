-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (-1, 0, 0), (0, NULL, 1), (NULL, 0, 1), (1, NULL, 1), (2, NULL, 1), (3, NULL, 0);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (3, NULL, NULL, 1), (3, -1, 0, 1), (NULL, 1, 1, NULL), (0, 0, 1, NULL), (1, 2, 0, NULL), (-1, 3, 0, 0), (0, 4, 1, 1), (1, 5, 0, 1), (0, 6, 0, 1), (1, 7, 1, 1), (3, 8, 0, 1), (0, 9, NULL, 0), (1, 10, 1, 1), (NULL, 11, 0, 0), (2, 12, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(6, 15)
*/

-- Prediction Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT BOX_ID, CHESTS.APPLE_COUNT, CHESTS.ORANGE_COUNT FROM BOXES INNER JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID UNION ALL SELECT BOX_ID, APPLE_COUNT, ORANGE_COUNT FROM BOXES) AS INN;

/*
Prediction Result:
(6, 17)
*/