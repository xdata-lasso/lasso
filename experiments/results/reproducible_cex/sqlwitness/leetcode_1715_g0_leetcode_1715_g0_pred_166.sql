-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (-1, NULL, NULL), (1, 1, 1), (NULL, 0, 0), (0, 0, NULL), (2, 1, 1);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (0, -1, 0, 0), (NULL, 0, 1, NULL), (NULL, NULL, 1, 1), (1, 1, 0, NULL), (NULL, 2, 0, 0), (1, 3, NULL, 0), (NULL, 4, NULL, NULL), (0, 5, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(3, 2)
*/

-- Prediction Query
SELECT SUM(COALESCE(A.APPLE_COUNT, 0) + COALESCE(B.APPLE_COUNT, 0)) AS APPLE_COUNT, SUM(A.ORANGE_COUNT + COALESCE(B.ORANGE_COUNT, 0)) AS ORANGE_COUNT FROM BOXES AS A LEFT JOIN CHESTS AS B ON B.CHEST_ID = A.CHEST_ID;

/*
Prediction Result:
(4, 2)
*/