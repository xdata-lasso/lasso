-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Web_client_accelerator (id, name, Operating_system, Client, Connection) VALUES (1, 'Squid', 'Linux', 'All', 'Broadband');
INSERT INTO Web_client_accelerator (id, name, Operating_system, Client, Connection) VALUES (2, 'Polipo', 'Windows', 'All', 'Dial-up');
INSERT INTO browser (id, name, market_share) VALUES (10, 'Safari', 18.5);
INSERT INTO browser (id, name, market_share) VALUES (20, 'Chrome', 65.2);
INSERT INTO browser (id, name, market_share) VALUES (5, 'Firefox', 3.1);
INSERT INTO browser (id, name, market_share) VALUES (15, 'Firefox', 4.8);
INSERT INTO browser (id, name, market_share) VALUES (1, 'Edge', 5.4);
INSERT INTO accelerator_compatible_browser (accelerator_id, browser_id, compatible_since_year) VALUES (1, 20, 2012);
INSERT INTO accelerator_compatible_browser (accelerator_id, browser_id, compatible_since_year) VALUES (2, 20, 2015);
INSERT INTO accelerator_compatible_browser (accelerator_id, browser_id, compatible_since_year) VALUES (1, 5, 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM browser ORDER BY name, browser.id NULLS LAST;

/*
Gold Result:
('Chrome',)
('Edge',)
('Firefox',)
('Firefox',)
('Safari',)
*/

-- Prediction Query
SELECT name FROM browser ORDER BY market_share DESC, browser.id NULLS LAST;

/*
Prediction Result:
('Chrome',)
('Safari',)
('Edge',)
('Firefox',)
('Firefox',)
*/