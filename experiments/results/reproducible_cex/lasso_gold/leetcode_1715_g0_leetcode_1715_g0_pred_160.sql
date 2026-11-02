-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1065, 1066, 1067);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (NULL, 1066, 1067);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1089, NULL, 1091);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (NULL, NULL, 1091);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1065, 1068, 1069, 1070);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, NULL, 1069, 1070);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1089, 1092, 1093, 1094);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, NULL, 1093, 1094);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(5390, 6486)
*/

-- Prediction Query
SELECT SUM(B.APPLE_COUNT + CASE WHEN NOT B.CHEST_ID IS NULL THEN C.APPLE_COUNT ELSE 0 END) AS APPLE_COUNT, SUM(B.ORANGE_COUNT + CASE WHEN NOT B.CHEST_ID IS NULL THEN C.ORANGE_COUNT ELSE 0 END) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID;

/*
Prediction Result:
(4297, 6486)
*/