-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO web_client_accelerator (id, name, operating_system, client, connection) VALUES (0, 'default2', NULL, NULL, 'Broadband'), (1, 'default2', NULL, 'default1', 'Broadband'), (2, 'default2', 'Broadband', 'Broadband', 'default1'), (3, 'default2', NULL, 'default1', NULL), (4, 'Broadband', 'default1', 'default2', 'default1'), (5, 'Broadband', NULL, 'Broadband', 'default1'), (6, 'default2', NULL, 'Broadband', NULL), (7, 'default1', 'default1', NULL, 'Broadband'), (8, 'Broadband', NULL, 'Broadband', 'default1'), (9, NULL, 'default1', NULL, 'default2'), (10, 'Broadband', 'default1', NULL, NULL), (11, NULL, NULL, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "operating_system" FROM "web_client_accelerator" WHERE ("connection" <> 'Broadband') ORDER BY name, web_client_accelerator.id NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, None)
('Broadband', 'default1')
('Broadband', None)
('Broadband', None)
('default2', 'Broadband')
*/

-- Prediction Query
SELECT name, operating_system FROM web_client_accelerator WHERE CONNECTION <> 'Broadband';

/*
Prediction Result:
('default2', 'Broadband')
('Broadband', 'default1')
('Broadband', None)
('Broadband', None)
(None, 'default1')
(None, None)
*/