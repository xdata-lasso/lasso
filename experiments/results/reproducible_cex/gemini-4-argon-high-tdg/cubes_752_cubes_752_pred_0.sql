-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (1, 'ZetaBoost', 'Windows', 'Desktop', 'Dial-up');
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (2, 'AlphaSpeed', 'Linux', 'Server', 'Broadband');
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (3, 'BetaCache', 'macOS', 'Desktop', 'ADSL');
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (4, 'AlphaSpeed', 'Android', 'Mobile', 'Cable');
INSERT INTO "browser" ("id", "name", "market_share") VALUES (1, 'Chrome', 65.5);
INSERT INTO "browser" ("id", "name", "market_share") VALUES (2, 'Firefox', 10.2);
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (1, 1, 2015);
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (1, 2, 2018);
INSERT INTO "accelerator_compatible_browser" ("accelerator_id", "browser_id", "compatible_since_year") VALUES (2, 1, 2016);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "operating_system" FROM "web_client_accelerator" WHERE ("connection" <> 'Broadband') ORDER BY name, web_client_accelerator.id NULLS LAST;

/*
Gold Result:
('AlphaSpeed', 'Android')
('BetaCache', 'macOS')
('ZetaBoost', 'Windows')
*/

-- Prediction Query
SELECT name, operating_system FROM web_client_accelerator WHERE CONNECTION <> 'Broadband';

/*
Prediction Result:
('ZetaBoost', 'Windows')
('BetaCache', 'macOS')
('AlphaSpeed', 'Android')
*/