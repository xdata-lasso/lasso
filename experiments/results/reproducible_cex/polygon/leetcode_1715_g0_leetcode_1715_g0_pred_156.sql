-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (16, 0, 0);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (15, 0, 1);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, NULL, 1, 1);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (16, 13, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(2, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT BOX_ID, BOXES.CHEST_ID, (BOXES.APPLE_COUNT + CHESTS.APPLE_COUNT) AS APPLE_COUNT, (BOXES.ORANGE_COUNT + CHESTS.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID GROUP BY BOX_ID UNION ALL SELECT * FROM BOXES WHERE CHEST_ID IS NULL) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(2, 1)
*/