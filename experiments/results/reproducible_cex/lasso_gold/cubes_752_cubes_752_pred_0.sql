-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "web_client_accelerator" ("id", "name", "operating_system", "client", "connection") VALUES (1015, 'Timothy Wong', 'expect', 'prove', 'Congress');
INSERT INTO "web_client_accelerator" ("id", "name", "operating_system", "client", "connection") VALUES (1016, 'Colleen Nguyen', 'politics', 'wish', 'push');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "operating_system" FROM "web_client_accelerator" WHERE ("connection" <> 'Broadband') ORDER BY name, web_client_accelerator.id NULLS LAST;

/*
Gold Result:
('Colleen Nguyen', 'politics')
('Timothy Wong', 'expect')
*/

-- Prediction Query
SELECT name, operating_system FROM web_client_accelerator WHERE CONNECTION <> 'Broadband';

/*
Prediction Result:
('Timothy Wong', 'expect')
('Colleen Nguyen', 'politics')
*/