-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "browser" ("id", "name", "market_share") VALUES (1018, 'Gabrielle Davis', 100);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (1020, 'Gabrielle Davis', -50);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (1022, 'Jamie Arnold', 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM browser ORDER BY name, browser.id NULLS LAST;

/*
Gold Result:
('Gabrielle Davis',)
('Gabrielle Davis',)
('Jamie Arnold',)
*/

-- Prediction Query
SELECT name FROM browser ORDER BY market_share DESC, browser.id NULLS LAST;

/*
Prediction Result:
('Gabrielle Davis',)
('Jamie Arnold',)
('Gabrielle Davis',)
*/