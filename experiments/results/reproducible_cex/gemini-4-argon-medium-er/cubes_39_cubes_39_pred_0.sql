-- Schema DDL
CREATE TABLE "i014" ("id" INTEGER, "string" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i014" ("id", "string") VALUES (1, 'a');
INSERT INTO "i014" ("id", "string") VALUES (1, 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "id", "concatstring" FROM (SELECT "id", GROUP_CONCAT("string", ', ') AS concatstring FROM i014 GROUP BY id) ORDER BY id, "id" NULLS LAST, "concatstring" NULLS LAST;

/*
Gold Result:
(1, 'a, b')
*/

-- Prediction Query
SELECT id, GROUP_CONCAT(string, ' ') FROM i014 GROUP BY id;

/*
Prediction Result:
(1, 'a b')
*/