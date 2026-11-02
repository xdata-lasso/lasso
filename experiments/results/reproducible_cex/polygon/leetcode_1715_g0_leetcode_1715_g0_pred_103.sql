-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (15, NULL, NULL);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (14, NULL, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (14, NULL, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(None, 0)
*/

-- Prediction Query
WITH TEMP AS (SELECT SUM(B.APPLE_COUNT + CASE WHEN B.CHEST_ID IS NULL THEN 0 ELSE C.APPLE_COUNT END) AS APPLE_COUNTS, SUM(B.ORANGE_COUNT + CASE WHEN B.CHEST_ID IS NULL THEN 0 ELSE C.ORANGE_COUNT END) AS ORANGE_COUNTS FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID GROUP BY B.BOX_ID) SELECT SUM(APPLE_COUNTS) AS APPLE_COUNT, SUM(ORANGE_COUNTS) AS ORANGE_COUNT FROM TEMP;

/*
Prediction Result:
(None, None)
*/