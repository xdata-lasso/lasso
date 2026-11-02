-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "web_client_accelerator" ("id", "name", "operating_system", "client", "connection") VALUES (1108, 'Todd Hudson', 'particular', 'phone', 'among');
INSERT INTO "web_client_accelerator" ("id", "name", "operating_system", "client", "connection") VALUES (1111, NULL, NULL, NULL, NULL);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (0, 'Jennifer Silva', 1109.5);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (-1, NULL, NULL);
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (1108, 0, 1110);
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (1111, -1, 1113);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.market_share AS market_share, RHS.accelerator_id AS accelerator_id, RHS.browser_id AS browser_id FROM browser AS LHS INNER JOIN (SELECT accelerator_id, browser_id, COUNT(*) AS n FROM accelerator_compatible_browser GROUP BY accelerator_id, browser_id) AS RHS ON (LHS.id = RHS.n)) ORDER BY id, name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.id, T1.name FROM browser AS T1 JOIN accelerator_compatible_browser AS T2 ON T1.id = T2.browser_id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.id NULLS LAST, T1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
(-1, None)
*/