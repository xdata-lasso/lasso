-- Schema DDL
CREATE TABLE "i014" ("id" INTEGER, "string" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP_CONCAT with ', ' separator, single-item group, duplicate values within a group, and ordering of IDs.
INSERT INTO i014 (id, string) VALUES (2, 'beta');
INSERT INTO i014 (id, string) VALUES (1, 'alpha');
INSERT INTO i014 (id, string) VALUES (1, 'alpha');
INSERT INTO i014 (id, string) VALUES (1, 'gamma');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "id", "concatstring" FROM (SELECT "id", GROUP_CONCAT("string", ', ') AS concatstring FROM i014 GROUP BY id) ORDER BY id, "id" NULLS LAST, "concatstring" NULLS LAST;

/*
Gold Result:
(1, 'alpha, alpha, gamma')
(2, 'beta')
*/

-- Prediction Query
SELECT id, GROUP_CONCAT(string, ' ') FROM i014 GROUP BY id;

/*
Prediction Result:
(1, 'alpha alpha gamma')
(2, 'beta')
*/