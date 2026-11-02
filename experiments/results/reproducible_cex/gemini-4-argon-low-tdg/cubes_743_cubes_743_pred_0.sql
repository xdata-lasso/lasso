-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard join condition (LHS.id = RHS.n where n=1), DISTINCT elimination across multiple RHS groups, and filtering out browsers where id != 1.
-- Also tests mutants that mistakenly join on LHS.id = RHS.browser_id or RHS.accelerator_id, or group by only one column.
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (10, 'FastCache', 'Linux', 'Server', 'Broadband');
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (20, 'SpeedyWeb', 'Windows', 'Desktop', 'Fiber');
INSERT INTO "browser" ("id", "name", "market_share") VALUES (1, 'AlphaBrowser', 45.5);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (2, 'BetaBrowser', 30.0);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (3, 'GammaBrowser', 15.2);
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (10, 2, 2018);
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (10, 3, 2020);
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (20, 2, 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.market_share AS market_share, RHS.accelerator_id AS accelerator_id, RHS.browser_id AS browser_id FROM browser AS LHS INNER JOIN (SELECT accelerator_id, browser_id, COUNT(*) AS n FROM accelerator_compatible_browser GROUP BY accelerator_id, browser_id) AS RHS ON (LHS.id = RHS.n)) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(1, 'AlphaBrowser')
*/

-- Prediction Query
SELECT T1.id, T1.name FROM browser AS T1 JOIN accelerator_compatible_browser AS T2 ON T1.id = T2.browser_id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.id NULLS LAST, T1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
(2, 'BetaBrowser')
*/