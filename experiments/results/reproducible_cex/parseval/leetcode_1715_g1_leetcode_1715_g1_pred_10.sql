-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: chests --
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1, 1644814318, 1465859724);

INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (2, 1620389964, 546571701);

INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (3, 947159877, 1990080517);

-- Inserting into table: boxes --
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483648, 44952191, 1151980946);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (3, -2147483647, 1155439218, 1313172851);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (3, -2147483646, 775304493, 373262291);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (3, -2147483645, 2074205376, 274769912);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (3, -2147483644, 2123196517, 364869063);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 2, 222415430, 556727997);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 3, 1178000634, 1836127587);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483641, 233994589, 1442655647);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483640, NULL, NULL);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483639, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM (SELECT SUM(B.APPLE_COUNT) AS APPLE_COUNT, SUM(B.ORANGE_COUNT) AS ORANGE_COUNT FROM BOXES AS B UNION ALL SELECT SUM(C.APPLE_COUNT) AS APPLE_COUNT, SUM(C.ORANGE_COUNT) AS ORANGE_COUNT FROM CHESTS AS C INNER JOIN BOXES AS B ON B.CHEST_ID = C.CHEST_ID) AS X;

/*
Gold Result:
(21440609510, 23149758683)
*/

-- Prediction Query
SELECT SUM(CASE WHEN B.CHEST_ID IS NULL THEN B.APPLE_COUNT ELSE B.APPLE_COUNT + C.APPLE_COUNT END) AS APPLE_COUNT, SUM(CASE WHEN B.CHEST_ID IS NULL THEN B.ORANGE_COUNT ELSE B.ORANGE_COUNT + C.ORANGE_COUNT END) AS ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON B.CHEST_ID = C.CHEST_ID;

/*
Prediction Result:
(18175405228, 21137327258)
*/