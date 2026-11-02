-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (16, NULL, 1);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (15, NULL, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (NULL, NULL, 0, 0);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (16, 13, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(0, 0)
*/

-- Prediction Query
SELECT SUM(T.APPLE_COUNT) + SUM(IIF(T.AP2, T.AP2, 0)) AS APPLE_COUNT, SUM(T.ORANGE_COUNT) + SUM(IIF(T.OR2, T.OR2, 0)) AS ORANGE_COUNT FROM (SELECT B.BOX_ID, B.APPLE_COUNT, B.ORANGE_COUNT, C.APPLE_COUNT AS AP2, C.ORANGE_COUNT AS OR2 FROM BOXES AS B LEFT JOIN CHESTS AS C USING (CHEST_ID)) AS T;

/*
Prediction Result:
(0, 1)
*/