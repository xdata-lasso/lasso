-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (35, 1, NULL);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (14, NULL, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (35, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT SUM(TEMP.APPLE + TEMP.APPLE2) AS APPLE_COUNT, SUM(TEMP.ORANGE + TEMP.ORANGE2) AS ORANGE_COUNT FROM (SELECT BOXES.BOX_ID, COALESCE(CHESTS.APPLE_COUNT, 0) AS APPLE, COALESCE(CHESTS.ORANGE_COUNT, 0) AS ORANGE, BOXES.APPLE_COUNT AS APPLE2, BOXES.ORANGE_COUNT AS ORANGE2 FROM BOXES LEFT JOIN CHESTS USING (CHEST_ID)) AS TEMP;

/*
Prediction Result:
(None, None)
*/