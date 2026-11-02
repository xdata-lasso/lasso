-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (0, 1058, 1059);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (NULL, 1058, 1059);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1072, 1065, 1066);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (NULL, 1065, 1066);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (0, 1060, 1061, 1062);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (0, NULL, 1061, 1062);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (0, 1067, NULL, 1069);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (0, NULL, NULL, 1069);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(4238, 8498)
*/

-- Prediction Query
WITH CTE AS (SELECT BOX_ID, SUM(BOXES.APPLE_COUNT) + SUM(COALESCE(CHESTS.APPLE_COUNT, 0)) AS APPLES, SUM(BOXES.ORANGE_COUNT) + SUM(COALESCE(CHESTS.ORANGE_COUNT, 0)) AS ORANGES FROM BOXES LEFT JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID GROUP BY BOX_ID) SELECT SUM(APPLES) AS APPLE_COUNT, SUM(ORANGES) AS ORANGE_COUNT FROM CTE;

/*
Prediction Result:
(5296, 8498)
*/