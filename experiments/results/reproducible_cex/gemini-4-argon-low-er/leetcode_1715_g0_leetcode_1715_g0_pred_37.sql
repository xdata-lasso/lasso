-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (1, 10, 20);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 1, 5, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(15, 30)
*/

-- Prediction Query
WITH TEMP AS (SELECT B.BOX_ID AS BOX_ID, B.APPLE_COUNT AS BOX_APPLE_COUNT, B.ORANGE_COUNT AS BOX_ORANGE_COUNT, C.APPLE_COUNT AS CHEST_APPLE_COUNT, C.ORANGE_COUNT AS CHEST_ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID) SELECT SUM(COALESCE(BOX_ORANGE_COUNT, 0) + COALESCE(CHEST_ORANGE_COUNT, 0)) AS ORANGE_COUNT, SUM(COALESCE(BOX_APPLE_COUNT, 0) + COALESCE(CHEST_APPLE_COUNT, 0)) AS APPLE_COUNT FROM TEMP;

/*
Prediction Result:
(30, 15)
*/