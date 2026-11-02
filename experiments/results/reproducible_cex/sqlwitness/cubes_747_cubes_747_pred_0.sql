-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO browser (id, name, market_share) VALUES (0, 'default1', NULL), (1, 'default1', NULL), (2, 'default1', 1.0), (3, NULL, 0.0), (4, 'default1', 1.0), (5, 'default1', NULL), (6, 'default1', 1.0), (7, 'default2', NULL), (8, 'default2', 0.0), (9, NULL, 1.0), (10, 'default2', 0.0);
INSERT INTO web_client_accelerator (id, name, operating_system, client, connection) VALUES (0, 'default1', NULL, 'default2', NULL), (1, NULL, 'default2', NULL, NULL), (2, NULL, NULL, NULL, 'default1'), (3, 'default1', 'default2', 'default2', NULL), (4, NULL, 'default1', 'default2', 'default1'), (5, NULL, 'default1', 'default2', 'default2'), (6, NULL, 'default2', NULL, 'default2'), (7, 'default2', 'default1', 'default1', 'default1'), (8, 'default1', NULL, NULL, NULL), (9, 'default2', 'default1', 'default1', NULL);
INSERT INTO accelerator_compatible_browser (accelerator_id, browser_id, compatible_since_year) VALUES (5, 7, NULL), (4, 2, 1), (2, 9, NULL), (8, 8, 1), (3, 6, 0), (9, 4, 0), (4, 5, 1), (3, 8, 1), (7, 9, 1), (4, 9, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.market_share AS market_share, RHS.id AS id_other, RHS.name AS name_other, RHS.operating_system AS operating_system, RHS.client AS client, RHS.connection AS CONNECTION, RHS.compatible_since_year AS compatible_since_year, RHS.accelerator_id AS accelerator_id FROM browser AS LHS INNER JOIN (SELECT id, name, operating_system, client, CONNECTION, browser_id, compatible_since_year, id AS accelerator_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.operating_system AS operating_system, LHS.client AS client, LHS.connection AS CONNECTION, RHS.browser_id AS browser_id, RHS.compatible_since_year AS compatible_since_year FROM web_client_accelerator AS LHS INNER JOIN accelerator_compatible_browser AS RHS ON (LHS.id = RHS.accelerator_id))) AS RHS ON (LHS.id = RHS.browser_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
(None, 'default2')
(None, None)
(None, None)
('default1', 'default1')
('default1', 'default2')
('default1', None)
('default1', None)
('default2', 'default1')
('default2', 'default1')
('default2', None)
*/

-- Prediction Query
SELECT T2.name, T3.name FROM accelerator_compatible_browser AS T1 JOIN browser AS T2 ON T1.browser_id = T2.id JOIN web_client_accelerator AS T3 ON T1.accelerator_id = T3.id ORDER BY T1.compatible_since_year DESC, T1.accelerator_id NULLS LAST, T1.browser_id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST;

/*
Prediction Result:
('default2', 'default1')
('default1', None)
('default1', None)
(None, 'default2')
('default2', 'default1')
('default1', 'default1')
('default1', 'default2')
(None, None)
(None, None)
('default2', None)
*/