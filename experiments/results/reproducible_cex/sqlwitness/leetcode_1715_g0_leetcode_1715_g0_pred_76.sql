-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (-1, 1, 1), (1, 0, NULL), (NULL, NULL, 0), (0, 0, 1), (2, 1, 0), (3, 1, 1), (4, 0, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (3, 1, 0, NULL), (0, 0, 0, NULL), (NULL, NULL, 0, 1), (1, -1, 1, 1), (4, 2, 1, NULL), (3, 3, 1, 0), (1, 4, 0, 0), (3, 5, 1, NULL), (0, 6, 0, 0), (2, 7, NULL, NULL), (3, 8, 1, 1), (-1, 9, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(11, 8)
*/

-- Prediction Query
SELECT SUM(B.APPLE_COUNT + COALESCE(C.APPLE_COUNT, 0)) AS APPLE_COUNT, SUM(B.ORANGE_COUNT + COALESCE(C.ORANGE_COUNT, 0)) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON COALESCE(B.CHEST_ID, 0) = C.CHEST_ID;

/*
Prediction Result:
(11, 9)
*/