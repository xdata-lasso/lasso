-- Schema DDL
CREATE TABLE "i013" ("orgName" TEXT, "id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i013 (orgName, id) VALUES ('OrgC', 100);
INSERT INTO i013 (orgName, id) VALUES ('OrgB', 20);
INSERT INTO i013 (orgName, id) VALUES ('OrgB', 10);
INSERT INTO i013 (orgName, id) VALUES ('OrgA', 3);
INSERT INTO i013 (orgName, id) VALUES ('OrgA', 1);
INSERT INTO i013 (orgName, id) VALUES ('OrgA', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT orgname, n, id FROM (SELECT LHS.orgname AS orgname, LHS.n AS n, RHS.id AS id FROM (SELECT * FROM (SELECT orgname, COUNT(*) AS n FROM i013 GROUP BY orgname) WHERE (n <> 1)) AS LHS INNER JOIN i013 AS RHS ON (LHS.orgname = RHS.orgname)) ORDER BY orgname, n NULLS LAST, id NULLS LAST;

/*
Gold Result:
('OrgA', 3, 1)
('OrgA', 3, 2)
('OrgA', 3, 3)
('OrgB', 2, 10)
('OrgB', 2, 20)
*/

-- Prediction Query
SELECT o.orgName, oc.dupeCount, o.id FROM i013 AS o JOIN (SELECT orgName, COUNT(*) AS dupeCount FROM i013 GROUP BY orgName HAVING COUNT(*) > 1) AS oc ON o.orgName = oc.orgName;

/*
Prediction Result:
('OrgB', 2, 20)
('OrgB', 2, 10)
('OrgA', 3, 3)
('OrgA', 3, 1)
('OrgA', 3, 2)
*/