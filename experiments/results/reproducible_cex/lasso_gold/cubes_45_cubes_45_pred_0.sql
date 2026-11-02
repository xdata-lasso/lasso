-- Schema DDL
CREATE TABLE "i013" ("orgName" TEXT, "id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i013" ("orgname", "id") VALUES ('Rodriguez, Figueroa and Sanchez', 1001);
INSERT INTO "i013" ("orgname", "id") VALUES ('Rodriguez, Figueroa and Sanchez', 1006.0);
INSERT INTO "i013" ("orgname", "id") VALUES ('Rodriguez, Figueroa and Sanchez', 1011.0);
INSERT INTO "i013" ("orgname", "id") VALUES ('Rodriguez, Figueroa and Sanchez', 1004);
INSERT INTO "i013" ("orgname", "id") VALUES ('Rodriguez, Figueroa and Sanchez', 1009.0);
INSERT INTO "i013" ("orgname", "id") VALUES ('Rodriguez, Figueroa and Sanchez', 1014.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT orgname, n, id FROM (SELECT LHS.orgname AS orgname, LHS.n AS n, RHS.id AS id FROM (SELECT * FROM (SELECT orgname, COUNT(*) AS n FROM i013 GROUP BY orgname) WHERE (n <> 1)) AS LHS INNER JOIN i013 AS RHS ON (LHS.orgname = RHS.orgname)) ORDER BY orgname, n NULLS LAST, id NULLS LAST;

/*
Gold Result:
('Rodriguez, Figueroa and Sanchez', 6, 1001)
('Rodriguez, Figueroa and Sanchez', 6, 1004)
('Rodriguez, Figueroa and Sanchez', 6, 1006)
('Rodriguez, Figueroa and Sanchez', 6, 1009)
('Rodriguez, Figueroa and Sanchez', 6, 1011)
('Rodriguez, Figueroa and Sanchez', 6, 1014)
*/

-- Prediction Query
SELECT o.orgName, oc.dupeCount, o.id FROM i013 AS o JOIN (SELECT orgName, COUNT(*) AS dupeCount FROM i013 GROUP BY orgName HAVING COUNT(*) > 1) AS oc ON o.orgName = oc.orgName;

/*
Prediction Result:
('Rodriguez, Figueroa and Sanchez', 6, 1001)
('Rodriguez, Figueroa and Sanchez', 6, 1006)
('Rodriguez, Figueroa and Sanchez', 6, 1011)
('Rodriguez, Figueroa and Sanchez', 6, 1004)
('Rodriguez, Figueroa and Sanchez', 6, 1009)
('Rodriguez, Figueroa and Sanchez', 6, 1014)
*/