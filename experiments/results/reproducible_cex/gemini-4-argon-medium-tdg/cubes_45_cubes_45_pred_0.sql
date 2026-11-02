-- Schema DDL
CREATE TABLE "i013" ("orgName" TEXT, "id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "i013" ("orgName", "id") VALUES ('Alpha', 100);
INSERT INTO "i013" ("orgName", "id") VALUES ('Beta', 200);
INSERT INTO "i013" ("orgName", "id") VALUES ('Beta', 10);
INSERT INTO "i013" ("orgName", "id") VALUES ('Gamma', 5);
INSERT INTO "i013" ("orgName", "id") VALUES ('Gamma', 5);
INSERT INTO "i013" ("orgName", "id") VALUES ('Gamma', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT orgname, n, id FROM (SELECT LHS.orgname AS orgname, LHS.n AS n, RHS.id AS id FROM (SELECT * FROM (SELECT orgname, COUNT(*) AS n FROM i013 GROUP BY orgname) WHERE (n <> 1)) AS LHS INNER JOIN i013 AS RHS ON (LHS.orgname = RHS.orgname)) ORDER BY orgname, n NULLS LAST, id NULLS LAST;

/*
Gold Result:
('Beta', 2, 10)
('Beta', 2, 200)
('Gamma', 3, 1)
('Gamma', 3, 5)
('Gamma', 3, 5)
*/

-- Prediction Query
SELECT o.orgName, oc.dupeCount, o.id FROM i013 AS o JOIN (SELECT orgName, COUNT(*) AS dupeCount FROM i013 GROUP BY orgName HAVING COUNT(*) > 1) AS oc ON o.orgName = oc.orgName;

/*
Prediction Result:
('Beta', 2, 200)
('Beta', 2, 10)
('Gamma', 3, 5)
('Gamma', 3, 5)
('Gamma', 3, 1)
*/