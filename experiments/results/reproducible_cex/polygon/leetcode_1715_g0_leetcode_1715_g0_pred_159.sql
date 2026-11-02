-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (31, NULL, 853);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (14, 0, 0);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, 13, 390, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (31, 32, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(391, None)
*/

-- Prediction Query
SELECT SUM(APPLE_SUB_COUNT) AS APPLE_COUNT, SUM(ORANGE_SUB_COUNT) AS ORANGE_COUNT FROM (SELECT B.BOX_ID, CASE WHEN B.CHEST_ID = C.CHEST_ID THEN B.APPLE_COUNT + C.APPLE_COUNT ELSE B.APPLE_COUNT END AS APPLE_SUB_COUNT, CASE WHEN B.CHEST_ID = C.CHEST_ID THEN B.ORANGE_COUNT + C.ORANGE_COUNT ELSE B.ORANGE_COUNT END AS ORANGE_SUB_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID GROUP BY BOX_ID) AS A;

/*
Prediction Result:
(390, None)
*/