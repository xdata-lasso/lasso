-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1076, 1077, 1078);
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1083, 1084, 1085);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1076, 1079, 1077, 1078);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1076, 1080, 1081, 1082);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1083, 1086, NULL, 1085);
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1083, 1087, NULL, 1089);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(6480, 8660)
*/

-- Prediction Query
WITH COLUM_WISE_COUNT AS (SELECT (BOXES.APPLE_COUNT + CHESTS.APPLE_COUNT) AS APPLE_COUNT, (BOXES.ORANGE_COUNT + CHESTS.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES INNER JOIN CHESTS ON BOXES.CHEST_ID = CHESTS.CHEST_ID UNION ALL SELECT APPLE_COUNT, ORANGE_COUNT FROM BOXES WHERE CHEST_ID IS NULL) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM COLUM_WISE_COUNT;

/*
Prediction Result:
(4312, 8660)
*/