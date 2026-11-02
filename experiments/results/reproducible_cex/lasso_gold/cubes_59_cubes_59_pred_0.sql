-- Schema DDL
CREATE TABLE "044_1" ("OriginalID" INTEGER, "Area" TEXT);

CREATE TABLE "044_2" ("Part" TEXT, "OriginalID" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "044_1" ("originalid", "area") VALUES (1017, 'knowledge');
INSERT INTO "044_1" ("originalid", "area") VALUES (1017, 'knowledg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT originalid, area FROM (SELECT * FROM "044_1" AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT part, originalid, part AS area FROM (SELECT LHS.part AS part, LHS.originalid AS originalid FROM "044_2" AS LHS INNER JOIN "044_1" AS RHS ON (LHS.originalid = RHS.originalid AND LHS.part = RHS.area))) AS RHS WHERE (LHS.area = RHS.area AND LHS.originalid = RHS.originalid))) ORDER BY originalid, area NULLS LAST;

/*
Gold Result:
(1017, 'knowledg')
(1017, 'knowledge')
*/

-- Prediction Query
SELECT a.originalID, a.area FROM "044_1" AS a WHERE NOT EXISTS(SELECT * FROM "044_2" AS c WHERE c.originalID = a.originalID AND c.part = a.area);

/*
Prediction Result:
(1017, 'knowledge')
(1017, 'knowledg')
*/