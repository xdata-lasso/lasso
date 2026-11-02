-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (19, NULL, 475);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (18, 0, 1);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (19, 17, NULL, 1676);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (19, 16, NULL, 4496);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(None, 7122)
*/

-- Prediction Query
WITH TMP AS (SELECT COALESCE(APPLE_COUNT, 0) AS APPLE_COUNT, COALESCE(ORANGE_COUNT, 0) AS ORANGE_COUNT FROM BOXES UNION ALL SELECT COALESCE(C.APPLE_COUNT, 0) AS APPLE_COUNT, COALESCE(C.ORANGE_COUNT, 0) AS ORANGE_COUNT FROM CHESTS AS C JOIN BOXES USING (CHEST_ID)) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM TMP;

/*
Prediction Result:
(0, 7122)
*/