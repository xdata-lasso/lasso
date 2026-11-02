-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (NULL, NULL, 1), (-1, NULL, 1), (0, 1, 0);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (NULL, 0, NULL, NULL), (0, -1, 1, NULL), (-1, 1, 1, 1), (-1, NULL, 0, NULL), (-1, 2, 0, NULL), (NULL, 3, 0, 1), (NULL, 4, 1, NULL), (0, 5, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(5, 3)
*/

-- Prediction Query
WITH CHEST_CTE AS (SELECT B.BOX_ID, C.CHEST_ID, COALESCE(C.APPLE_COUNT, 0) AS CHEST_APPLE_COUNT, COALESCE(C.ORANGE_COUNT, 0) AS CHEST_ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID) SELECT SUM(SUB.APPLE_COUNT) + SUM(SUB.CHEST_APPLE_COUNT) AS APPLE_COUNT, SUM(SUB.ORANGE_COUNT) + SUM(SUB.CHEST_ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT B.APPLE_COUNT, B.ORANGE_COUNT, CC.CHEST_APPLE_COUNT, CC.CHEST_ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHEST_CTE AS CC ON B.BOX_ID = CC.BOX_ID) AS SUB;

/*
Prediction Result:
(5, 4)
*/