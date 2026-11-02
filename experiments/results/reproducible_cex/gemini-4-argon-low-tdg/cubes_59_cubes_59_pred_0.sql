-- Schema DDL
CREATE TABLE "044_1" ("OriginalID" INTEGER, "Area" TEXT);

CREATE TABLE "044_2" ("Part" TEXT, "OriginalID" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (1, NULL);
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (NULL, 'A');
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (NULL, NULL);
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (2, 'B');
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (2, NULL);
INSERT INTO "044_2" ("Part", "OriginalID") VALUES (NULL, 1);
INSERT INTO "044_2" ("Part", "OriginalID") VALUES ('A', NULL);
INSERT INTO "044_2" ("Part", "OriginalID") VALUES (NULL, NULL);
INSERT INTO "044_2" ("Part", "OriginalID") VALUES ('B', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT originalid, area FROM (SELECT * FROM "044_1" AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT part, originalid, part AS area FROM (SELECT LHS.part AS part, LHS.originalid AS originalid FROM "044_2" AS LHS INNER JOIN "044_1" AS RHS ON (LHS.originalid = RHS.originalid AND LHS.part = RHS.area))) AS RHS WHERE (LHS.area = RHS.area AND LHS.originalid = RHS.originalid))) ORDER BY originalid, area NULLS LAST;

/*
Gold Result:
(None, 'A')
(None, None)
(1, None)
(2, None)
*/

-- Prediction Query
SELECT a.originalID, a.area FROM "044_1" AS a WHERE NOT EXISTS(SELECT * FROM "044_2" AS c WHERE c.originalID = a.originalID AND c.part = a.area);

/*
Prediction Result:
(1, None)
(None, 'A')
(None, None)
(2, None)
*/