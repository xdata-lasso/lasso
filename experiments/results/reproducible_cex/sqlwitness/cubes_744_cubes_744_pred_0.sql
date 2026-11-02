-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO browser (id, name, market_share) VALUES (1, 'Safari', 1.0), (0, 'Safari', NULL), (2, 'default1', 1.0), (3, NULL, 0.0), (4, 'default2', 1.0), (5, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "id", "market_share" FROM "browser" WHERE ("name" = 'Safari') ORDER BY id;

/*
Gold Result:
(0, None)
(1, 1.0)
*/

-- Prediction Query
SELECT id, market_share FROM browser WHERE name = 'Safari';

/*
Prediction Result:
(0, None)
(1, 1.0)
*/