-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (16, 0, 1);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (15, 0, 0);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, 14, NULL, 0);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (16, 13, 9910, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(9910, 0)
*/

-- Prediction Query
WITH A AS (SELECT BOX_ID, CHEST_ID, B.APPLE_COUNT AS BA, B.ORANGE_COUNT AS BO, C.APPLE_COUNT AS CA, C.ORANGE_COUNT AS CO FROM BOXES AS B LEFT JOIN CHESTS AS C USING (CHEST_ID)) SELECT SUM(BA) + SUM(IIF(NOT CHEST_ID IS NULL, CA, 0)) AS APPLE_COUNT, SUM(BO) + SUM(IIF(NOT CHEST_ID IS NULL, CO, 0)) AS ORANGE_COUNT FROM A;

/*
Prediction Result:
(9910, 1)
*/