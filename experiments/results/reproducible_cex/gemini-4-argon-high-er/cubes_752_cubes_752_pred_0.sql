-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (1, 'B', 'Windows', 'Client1', 'Dial-up');
INSERT INTO "Web_client_accelerator" ("id", "name", "Operating_system", "Client", "Connection") VALUES (2, 'A', 'Linux', 'Client2', 'Dial-up');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "operating_system" FROM "web_client_accelerator" WHERE ("connection" <> 'Broadband') ORDER BY name, web_client_accelerator.id NULLS LAST;

/*
Gold Result:
('A', 'Linux')
('B', 'Windows')
*/

-- Prediction Query
SELECT name, operating_system FROM web_client_accelerator WHERE CONNECTION <> 'Broadband';

/*
Prediction Result:
('B', 'Windows')
('A', 'Linux')
*/