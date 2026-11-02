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

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 2, 2123196517, 364869063);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, 3, 222415430, 556727997);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483642, 1178000634, NULL);

INSERT INTO "boxes" ("chest_id", "box_id", "apple_count", "orange_count") VALUES (1, -2147483641, NULL, 1836127587);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(b.apple_count + COALESCE(c.apple_count, 0)) AS apple_count, SUM(b.orange_count + COALESCE(c.orange_count, 0)) AS orange_count FROM Boxes AS b LEFT JOIN Chests AS c ON b.chest_id = c.chest_id;

/*
Gold Result:
(16994250762, 17704591094)
*/

-- Prediction Query
WITH APP_OR AS (SELECT B.BOX_ID, C.CHEST_ID, C.APPLE_COUNT, C.ORANGE_COUNT FROM BOXES AS B LEFT JOIN CHESTS AS C ON C.CHEST_ID = B.CHEST_ID UNION ALL SELECT BOX_ID, CHEST_ID, APPLE_COUNT, ORANGE_COUNT FROM BOXES) SELECT SUM(APPLE_COUNT) AS APPLE_COUNT, SUM(ORANGE_COUNT) AS ORANGE_COUNT FROM APP_OR;

/*
Prediction Result:
(18639065080, 19170450818)
*/