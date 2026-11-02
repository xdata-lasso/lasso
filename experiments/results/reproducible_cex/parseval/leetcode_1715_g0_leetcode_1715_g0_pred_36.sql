-- Schema DDL
CREATE TABLE "Chests" ("chest_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, UNIQUE ("chest_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

CREATE TABLE "Boxes" ("chest_id" INTEGER, "box_id" INTEGER, "apple_count" INTEGER, "orange_count" INTEGER, FOREIGN KEY ("chest_id") REFERENCES "Chests" ("chest_id"), UNIQUE ("box_id"), CHECK ("apple_count" >= 0), CHECK ("orange_count" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: chests --
INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (1, 1644814318, 1465859724);

INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (3, 1620389964, 546571701);

INSERT INTO "chests" ("chest_id", "apple_count", "orange_count") VALUES (2, 947159877, 1990080517);

-- Inserting into table: boxes --
INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483648, 44952191, 1151980946);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483647, 1155439218, 1313172851);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483646, 775304493, 373262291);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (2, -2147483645, 2074205376, 274769912);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 2, 2123196517, 364869063);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 3, 222415430, 556727997);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483642, NULL, 1178000634);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483641, 1836127587, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(17652377715, 17046464141)
*/

-- Prediction Query
WITH T1 AS (SELECT A.*, B.APPLE_COUNT AS APPLE2, B.ORANGE_COUNT AS ORANGE2 FROM BOXES AS A LEFT JOIN CHESTS AS B ON A.CHEST_ID = B.CHEST_ID), T2 AS (SELECT BOX_ID, CHEST_ID, COALESCE(APPLE_COUNT, 0) + COALESCE(APPLE2, 0) AS APPLE, COALESCE(ORANGE_COUNT, 0) + COALESCE(ORANGE2, 0) AS ORANGE FROM T1) SELECT SUM(APPLE) AS APPLE_COUNT, SUM(ORANGE) AS ORANGE_COUNT FROM T2;

/*
Prediction Result:
(19297192033, 18512323865)
*/