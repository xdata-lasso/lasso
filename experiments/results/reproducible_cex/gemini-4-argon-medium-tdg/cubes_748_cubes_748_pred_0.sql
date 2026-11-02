-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by name (anti-correlation between id, name, and market_share), duplicate names (to catch DISTINCT mutants), and unreferenced browsers (to catch inner join mutants).
INSERT INTO "browser" ("id", "name", "market_share") VALUES (1, 'Opera', 10.5);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (2, 'Chrome', 65.2);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (3, 'Firefox', 15.0);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (4, 'Chrome', 5.0);
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (1, 'FasterFox', 'Windows', 'Desktop', 'Broadband');
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (1, 2, 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM browser ORDER BY name, browser.id NULLS LAST;

/*
Gold Result:
('Chrome',)
('Chrome',)
('Firefox',)
('Opera',)
*/

-- Prediction Query
SELECT name FROM browser ORDER BY market_share DESC, browser.id NULLS LAST;

/*
Prediction Result:
('Chrome',)
('Firefox',)
('Opera',)
('Chrome',)
*/