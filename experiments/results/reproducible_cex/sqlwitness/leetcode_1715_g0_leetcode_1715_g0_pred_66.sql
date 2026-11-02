-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (1, 1, 0), (-1, 0, 0), (NULL, 0, 0), (0, NULL, NULL), (2, 0, 1), (3, 0, 0), (4, 0, NULL), (5, NULL, 0), (6, 1, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (5, 0, NULL, 0), (0, -1, 1, NULL), (4, 1, 1, 1), (5, NULL, 1, NULL), (4, 2, 1, 1), (3, 3, 0, 0), (5, 4, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(4, 3)
*/

-- Prediction Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT BOX_ID, B.CHEST_ID, B.APPLE_COUNT + C.APPLE_COUNT AS APPLE_COUNT, B.ORANGE_COUNT + C.ORANGE_COUNT AS ORANGE_COUNT FROM BOXES AS B JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID UNION ALL SELECT * FROM BOXES WHERE CHEST_ID IS NULL) AS A;

/*
Prediction Result:
(2, 1)
*/