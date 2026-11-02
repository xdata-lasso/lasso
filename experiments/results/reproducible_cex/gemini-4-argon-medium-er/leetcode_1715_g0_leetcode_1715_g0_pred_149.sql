-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, 1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT SUM(COALESCE(T1.APPLE_COUNT, 0) + COALESCE(T2.APPLE_COUNT, 0)) AS APPLE_COUNT, SUM(COALESCE(T1.ORANGE_COUNT, 0) + COALESCE(T2.ORANGE_COUNT, 0)) AS ORANGE_COUNT FROM BOXES AS T1 LEFT JOIN CHESTS AS T2 ON T1.CHEST_ID = T2.CHEST_ID;

/*
Prediction Result:
(0, 1)
*/