-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (1, 10, 10);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 1, NULL, 5);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 2, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(15, 30)
*/

-- Prediction Query
WITH NUM AS (SELECT CHEST_ID, COUNT(CHEST_ID) AS C FROM BOXES GROUP BY CHEST_ID HAVING NOT CHEST_ID IS NULL), T AS (SELECT SUM(COALESCE(N.C, 0) * CO.APPLE_COUNT) AS APPLE, SUM(COALESCE(N.C, 0) * CO.ORANGE_COUNT) AS ORANGE FROM CHESTS AS CO JOIN NUM AS N ON N.CHEST_ID = CO.CHEST_ID) SELECT SUM(BOXES.APPLE_COUNT) + COALESCE(T.APPLE, 0) AS APPLE_COUNT, SUM(BOXES.ORANGE_COUNT) + COALESCE(T.ORANGE, 0) AS ORANGE_COUNT FROM BOXES CROSS JOIN T;

/*
Prediction Result:
(25, 30)
*/