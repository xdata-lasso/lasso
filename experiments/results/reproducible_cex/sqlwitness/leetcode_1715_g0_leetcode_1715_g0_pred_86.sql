-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (NULL, NULL, NULL), (1, NULL, 1), (0, 1, NULL);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (NULL, NULL, NULL, 1), (0, -1, 1, 1), (0, 0, NULL, 1), (NULL, 1, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(3, 3)
*/

-- Prediction Query
SELECT SUM(IIF(A.CHEST_ID IN (SELECT CHEST_ID FROM CHESTS), A.APPLES_BOX + C.APPLE_COUNT, A.APPLES_BOX)) AS APPLE_COUNT, SUM(IIF(A.CHEST_ID IN (SELECT CHEST_ID FROM CHESTS), A.ORANGE_BOX + C.ORANGE_COUNT, A.ORANGE_BOX)) AS ORANGE_COUNT FROM (SELECT BOX_ID, CHEST_ID, SUM(APPLE_COUNT) AS APPLES_BOX, SUM(ORANGE_COUNT) AS ORANGE_BOX FROM BOXES GROUP BY BOX_ID) AS A LEFT JOIN CHESTS AS C ON A.CHEST_ID = C.CHEST_ID;

/*
Prediction Result:
(3, 1)
*/