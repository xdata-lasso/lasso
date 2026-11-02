-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (36, 946, 0);
INSERT INTO "Chests" ("chest_id", "apple_count", "orange_count") VALUES (15, NULL, NULL);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (36, 37, NULL, 1);
INSERT INTO "Boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (15, 14, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(946, 1)
*/

-- Prediction Query
SELECT SUM(APPLE_COUNT) + SUM(CHEST_APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) + SUM(CHEST_ORGANCE_COUNT) AS ORANGE_COUNT FROM (SELECT BOX_ID, BOXES.APPLE_COUNT, BOXES.ORANGE_COUNT, CASE WHEN NOT CHESTS.CHEST_ID IS NULL THEN CHESTS.APPLE_COUNT ELSE 0 END AS CHEST_APPLE_COUNT, CASE WHEN NOT CHESTS.CHEST_ID IS NULL THEN CHESTS.ORANGE_COUNT ELSE 0 END AS CHEST_ORGANCE_COUNT FROM BOXES LEFT JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID GROUP BY 1) AS T;

/*
Prediction Result:
(None, 1)
*/