-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO browser (id, name, market_share) VALUES (1, 'default1', 0.0), (0, NULL, 1.0), (2, 'default2', 0.0), (3, 'default2', 0.0), (4, 'default1', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name, market_share FROM browser ORDER BY id;

/*
Gold Result:
(0, None, 1.0)
(1, 'default1', 0.0)
(2, 'default2', 0.0)
(3, 'default2', 0.0)
(4, 'default1', 0.0)
*/

-- Prediction Query
SELECT id, name, market_share FROM browser;

/*
Prediction Result:
(0, None, 1.0)
(1, 'default1', 0.0)
(2, 'default2', 0.0)
(3, 'default2', 0.0)
(4, 'default1', 0.0)
*/