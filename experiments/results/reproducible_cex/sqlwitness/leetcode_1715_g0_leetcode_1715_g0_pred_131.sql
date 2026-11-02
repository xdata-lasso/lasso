-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO chests (chest_id, apple_count, orange_count) VALUES (NULL, NULL, NULL), (0, 0, 1);
INSERT INTO boxes (chest_id, box_id, apple_count, orange_count) VALUES (0, 0, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT APP1 + APP2 AS APPLE_COUNT, ORG1 + ORG2 AS ORANGE_COUNT FROM (SELECT COALESCE(SUM(APPLE_COUNT), 0) AS APP1, COALESCE(SUM(APP), 0) AS APP2, COALESCE(SUM(ORANGE_COUNT), 0) AS ORG1, COALESCE(SUM(ORG), 0) AS ORG2 FROM (SELECT A.*, B.APPLE_COUNT AS APP, B.ORANGE_COUNT AS ORG FROM BOXES AS A LEFT JOIN CHESTS AS B ON A.CHEST_ID = B.CHEST_ID) AS A) AS A;

/*
Prediction Result:
(0, 1)
*/