-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1065, 1066, 1067);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (NULL, 1066, 1067);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1073, 1074, 1075);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (NULL, 1074, 1075);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1065, 1068, 1069, 1070);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, NULL, 1069, 1070);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1073, 1076, NULL, 1078);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, NULL, NULL, 1078);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(3204, 6438)
*/

-- Prediction Query
WITH BOX_CNTS AS (SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES), CHEST_CNTS AS (SELECT SUM(C.APPLE_COUNT), SUM(C.ORANGE_COUNT) FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID), BOX_CHEST_CNTS AS (SELECT * FROM BOX_CNTS UNION ALL SELECT * FROM CHEST_CNTS) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM BOX_CHEST_CNTS;

/*
Prediction Result:
(4278, 6438)
*/