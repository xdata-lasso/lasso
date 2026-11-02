-- Schema DDL
CREATE TABLE "i014" ("id" INTEGER, "string" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i014" ("id", "string") VALUES (1004, 'face');
INSERT INTO "i014" ("id", "string") VALUES (1004, 'face');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "id", "concatstring" FROM (SELECT "id", GROUP_CONCAT("string", ', ') AS concatstring FROM i014 GROUP BY id) ORDER BY id, "id" NULLS LAST, "concatstring" NULLS LAST;

/*
Gold Result:
(1004, 'face, face')
*/

-- Prediction Query
SELECT id, GROUP_CONCAT(string, ' ') FROM i014 GROUP BY id;

/*
Prediction Result:
(1004, 'face face')
*/