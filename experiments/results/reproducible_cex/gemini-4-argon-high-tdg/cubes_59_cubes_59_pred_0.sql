-- Schema DDL
CREATE TABLE "044_1" ("OriginalID" INTEGER, "Area" TEXT);

CREATE TABLE "044_2" ("Part" TEXT, "OriginalID" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (1, NULL);
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (1, 'Alpha');
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (1, 'Beta');
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (NULL, 'Alpha');
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (NULL, NULL);
INSERT INTO "044_1" ("OriginalID", "Area") VALUES (2, 'Gamma');
INSERT INTO "044_2" ("Part", "OriginalID") VALUES (NULL, 1);
INSERT INTO "044_2" ("Part", "OriginalID") VALUES ('Alpha', NULL);
INSERT INTO "044_2" ("Part", "OriginalID") VALUES (NULL, NULL);
INSERT INTO "044_2" ("Part", "OriginalID") VALUES ('Gamma', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT originalid, area FROM (SELECT * FROM "044_1" AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT part, originalid, part AS area FROM (SELECT LHS.part AS part, LHS.originalid AS originalid FROM "044_2" AS LHS INNER JOIN "044_1" AS RHS ON (LHS.originalid = RHS.originalid AND LHS.part = RHS.area))) AS RHS WHERE (LHS.area = RHS.area AND LHS.originalid = RHS.originalid))) ORDER BY originalid, area NULLS LAST;

/*
Gold Result:
(None, 'Alpha')
(None, None)
(1, 'Alpha')
(1, 'Beta')
(1, None)
*/

-- Prediction Query
SELECT a.originalID, a.area FROM "044_1" AS a WHERE NOT EXISTS(SELECT * FROM "044_2" AS c WHERE c.originalID = a.originalID AND c.part = a.area);

/*
Prediction Result:
(1, None)
(1, 'Alpha')
(1, 'Beta')
(None, 'Alpha')
(None, None)
*/