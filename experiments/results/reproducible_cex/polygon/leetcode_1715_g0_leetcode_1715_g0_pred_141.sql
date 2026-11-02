-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (28, 1289, 853);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (14, 1, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (28, 27, 0, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (14, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(1289, 1)
*/

-- Prediction Query
SELECT APPLE1 + APPLE2 AS APPLE_COUNT, ORANGE1 + ORANGE2 AS ORANGE_COUNT FROM (SELECT COALESCE(SUM(B.APPLE_COUNT), 0) AS APPLE1, COALESCE(SUM(C.APPLE_COUNT), 0) AS APPLE2, COALESCE(SUM(B.ORANGE_COUNT), 0) AS ORANGE1, COALESCE(SUM(C.ORANGE_COUNT), 0) AS ORANGE2 FROM BOXES AS B LEFT JOIN CHESTS AS C USING (CHEST_ID)) AS TEMP;

/*
Prediction Result:
(1290, 854)
*/